Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40727A12B
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886030; cv=none; b=UhfafQAQSNGet05uyhJLF31bZWyMXY/jc4esBd2YNBd9lYBpWKtKs8z4+wMBApTwcdpw3XPdjXfTsqVl3vRJmMzpdSUYued3TqYAlksd8KAheOY10NPWfPuQ3UZZbgNJmpUJ9OaUYx4sfDq9B2+1mVEqOOA2abijxtRvJUS+4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886030; c=relaxed/simple;
	bh=n+WE1rkvruRWBwuylHCmnNbgdwSAUFW6rtoIp0bkEPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTJWv6XGaxZrFqjtFUSIZ0+1VtFFxgwvS1e0zgq1jL/dhzZRDXx895U/nKRK9sP7YWUpDZ1UZ+o1GqFywmWESy28wPk3P4HMQsYGKodbroscPdnQo8D8jlp6MGQ67H1SuVie5aQz7U2S5TaxXcXKpof6YmOpEpl082Q5+c+I1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sefvg76P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sefvg76P"
Received: from localhost (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id A5CE9211C28C;
	Thu,  4 Dec 2025 14:07:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5CE9211C28C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764886026;
	bh=OgHYpvFT9iWC3AugjVPHeYq63t/rKQ7He91qwnYSCJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sefvg76PfK6brKFGExXFISzZmSLFmeJk3V2bAAbknoqnrbrJokbAVR6ARTDYHzKjT
	 yDQRyiEGZEodwAKSgUPd4YgqwqC/aYccM1Axomj/1FXHAIrhFoLNfCk08BxyV+OPfC
	 bu78+EFqgWTtoCF4HTySkaEe6/4crWrJTCt4uGjw=
Date: Thu, 4 Dec 2025 14:07:04 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Zhang
 Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, David Matlack <dmatlack@google.com>, Alex
 Williamson <alex@shazbot.org>
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Message-ID: <20251204140704.000043b1@linux.microsoft.com>
In-Reply-To: <0f3dad6d-b320-4d6d-a0b2-8919f3fca5e3@arm.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-3-jacob.pan@linux.microsoft.com>
	<f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
	<20251202160635.0000433e@linux.microsoft.com>
	<20251203131129.GD1109247@nvidia.com>
	<20251203143609.00006b72@linux.microsoft.com>
	<0f3dad6d-b320-4d6d-a0b2-8919f3fca5e3@arm.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Robin,

On Thu, 4 Dec 2025 10:53:36 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2025-12-03 10:36 pm, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 3 Dec 2025 09:11:29 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> >> On Tue, Dec 02, 2025 at 04:06:35PM -0800, Jacob Pan wrote:  
> >>> However, as you pointed out there seems to be no standard ordering
> >>> for iommu device registration across platforms. e.g. VT-d hooks up
> >>> with x86_init, smmuv3 does that in platform driver probe. This
> >>> patchset puts dummy driver under early_initcall which is after
> >>> both but not a guarantee for all platforms. Any suggestions?  
> >>
> >> I think we need to do something more like the sefltest does and
> >> manually bind a driver to a device so this init time ordering
> >> shouldn't matter.  
> > I have moved this dummy iommu driver init under iommufd_init(),
> > which aligns well since it runs after all physical IOMMU drivers
> > have registered. This dummy driver is intended for iommufd after
> > all. But I don't see a need to bind to a platform device as the
> > selttest does.  
> 
> There is no "after all physical IOMMU drivers have registered", there
> is only "after we've given up waiting to see if one might be loaded
> as a module", but even that may be indefinite depending on
> build/runtime configuration.
OK, how about we make loading the dummy driver an explicit user opt-in,
the same way as /sys/module/iommufd/parameters/allow_unsafe_interrupt?

In addition, make sure once noiommu driver is loaded, no other iommu
device can be registered.

diff --git a/drivers/iommu/iommufd/device.c
b/drivers/iommu/iommufd/device.c index 4c842368289f..233e2a8a59b9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -18,6 +18,41 @@ MODULE_PARM_DESC(
        "Allow IOMMUFD to bind to devices even if the platform cannot
isolate " "the MSI interrupt window. Enabling this is a security
weakness."); 
+static bool allow_unsafe_dma;
+
+static int allow_unsafe_dma_set(const char *val, const struct
kernel_param *kp) +{
+       int ret;
+       bool newv;
+
+       ret = kstrtobool(val, &newv);
+       if (ret)
+               return ret;
+       /* If set, call noiommu_init() to load dummy noiommu driver */
+       if (newv && !allow_unsafe_dma) {
+               /* Will fail if HW IOMMU is present */
+               ret = noiommu_init();
+               if (ret)
+                       return ret;
+               allow_unsafe_dma = newv;
+       }
+
+       return 0;
+}
+
+static int allow_unsafe_dma_get(char *buf, const struct kernel_param
*kp) +{
+    return param_get_bool(buf, kp);
+}
+
+static const struct kernel_param_ops allow_unsafe_dma_ops = {
+    .set = allow_unsafe_dma_set,
+    .get = allow_unsafe_dma_get,
+};
+
+module_param_cb(allow_unsafe_dma, &allow_unsafe_dma_ops,
&allow_unsafe_dma, 0644); +MODULE_PARM_DESC(allow_unsafe_dma, "Enable
unsafe DMA no-IOMMU mode"); +
 struct iommufd_attach {
        struct iommufd_hw_pagetable *hwpt;
        struct xarray device_array;
