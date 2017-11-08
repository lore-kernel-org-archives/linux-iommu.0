From: Bharat Kumar Gogada <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Wed, 8 Nov 2017 17:50:40 +0000
Message-ID: <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<20171006133203.22803-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

+static struct iommu_process *
+iommu_process_alloc(struct iommu_domain *domain, struct task_struct 
+*task) {
+	int err;
+	int pasid;
+	struct iommu_process *process;
+
+	if (WARN_ON(!domain->ops->process_alloc || !domain->ops->process_free))
+		return ERR_PTR(-ENODEV);
+
+	process = domain->ops->process_alloc(task);
+	if (IS_ERR(process))
+		return process;
+	if (!process)
+		return ERR_PTR(-ENOMEM);
+
+	process->pid		= get_task_pid(task, PIDTYPE_PID);
+	process->release	= domain->ops->process_free;
+	INIT_LIST_HEAD(&process->domains);
+	kref_init(&process->kref);
+
+	if (!process->pid) {
+		err = -EINVAL;
+		goto err_free_process;
+	}
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_process_lock);
+	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
+				 domain->max_pasid + 1, GFP_ATOMIC);
If EP supports only one pasid; domain->min_pasid=1 and domain->max_pasid=0.
When idr_alloc_cyclic is called it invokes idr_get_free_cmn function where we have following condition. (Based on kernel 4.14-rc6)
	if (!radix_tree_tagged(root, IDR_FREE)) 
                start = max(start, maxindex + 1);
              if (start > max) 
		return ERR_PTR(-ENOSPC);
Here max is being assigned zero by the time this function is invoked, this value is based on domain->max_pasid.
This condition fails and ENOSPC is returned.
	
In this case even though hardware supports PASID, BIND flow fails.
Any reason why pasid allocation moved to idr allocations rather than bitmap allocations as in v1 patches ?

+	process->pasid = pasid;

Regards,
Bharat
