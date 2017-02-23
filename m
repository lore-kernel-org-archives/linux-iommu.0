From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: intel-iommu sysfs oops.
Date: Fri, 24 Feb 2017 00:30:38 +0100
Message-ID: <20170223233038.GH4154@suse.de>
References: <20170223194406.i3scsushn7bbizdv@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170223194406.i3scsushn7bbizdv-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Dave,

On Thu, Feb 23, 2017 at 02:44:06PM -0500, Dave Jones wrote:
> cat /sys/devices/virtual/iommu/dmar0/intel-iommu/version
> 
> Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC

Thanks for the report, the problem reproduces easily here. The diff
below fixes the issue on Intel, AMD has the same problem and needs a
similar fix I'll do shortly.

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f5e02f8..ec3f6c8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4730,11 +4730,16 @@ static int intel_iommu_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
+{
+	return container_of(dev, struct intel_iommu, iommu.dev);
+}
+
 static ssize_t intel_iommu_show_version(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	u32 ver = readl(iommu->reg + DMAR_VER_REG);
 	return sprintf(buf, "%d:%d\n",
 		       DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver));
@@ -4745,7 +4750,7 @@ static ssize_t intel_iommu_show_address(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->reg_phys);
 }
 static DEVICE_ATTR(address, S_IRUGO, intel_iommu_show_address, NULL);
@@ -4754,7 +4759,7 @@ static ssize_t intel_iommu_show_cap(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->cap);
 }
 static DEVICE_ATTR(cap, S_IRUGO, intel_iommu_show_cap, NULL);
@@ -4763,7 +4768,7 @@ static ssize_t intel_iommu_show_ecap(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->ecap);
 }
 static DEVICE_ATTR(ecap, S_IRUGO, intel_iommu_show_ecap, NULL);
@@ -4772,7 +4777,7 @@ static ssize_t intel_iommu_show_ndoms(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%ld\n", cap_ndoms(iommu->cap));
 }
 static DEVICE_ATTR(domains_supported, S_IRUGO, intel_iommu_show_ndoms, NULL);
@@ -4781,7 +4786,7 @@ static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%d\n", bitmap_weight(iommu->domain_ids,
 						  cap_ndoms(iommu->cap)));
 }
