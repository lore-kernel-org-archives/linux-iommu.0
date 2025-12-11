Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2E4400
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765426684; cv=none; b=dqNRM2ceBrfEQFXdHmjONHCs8UNS8W5qhDZk5B4MBoBnMXQroLZuenZsZspZTCMSU1jjkQfbwrRZeRDlT/lomRsIE94g3nW0ltRxQI1LsSkgM7AzDJc5lIt629beBWN/KgyVMZ76VaeDgfrvDJTD/IzlX5cWiAgV6IxCZzdQys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765426684; c=relaxed/simple;
	bh=hSsBqGM03RkYT6B1UfLrOyg0LwJA+TOZSMGnQCyHeGE=;
	h=To:Cc:From:Date:Content-Type:Subject:Message-Id:Mime-Version:
	 In-Reply-To:References; b=rTQsptOxT02h4PEem0M4ZSBNn16OoW98Qgymv8cP7GPqo45g5+Ukg6smB5fP6tudpcWInKR3mSNSgAnH34j5ss81iYVW2JKOB9JcnZSHWZbid7cffGXWsMmA3j5PoMI5zpxLPI3nuXlCvf8Ie1Fx8OuqWgvMajiRPJLD/ETVpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bp4giZOC; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bp4giZOC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765426675; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Cqz07PQNXLmM+OTndmKNcXhC/jyGV+A/BIxRvkrjb+M=;
 b=bp4giZOCT/0rqBm2MbUYLdrN7nsdAfUUomlJjBlbZS1Z9GiWsoPo6kbsecdZGZtaOtmHvU
 wkWtX0dL3iI00Ojif1uSy7fg8SGqX41hwDEIdprVPS/bg4DNKytd7/vFybFTQY/2XDGBeD
 luPQWxU6hWG8mM3P6TfdgrezbAsE1HJGTXYOcXKQwwuUmbX/ZQXP0+4enuKW69f2zlAac9
 JDUuInDNP8R+CneRhrnpDY4w9xtCMkDAt56bEMluoCoV0E/wQNya4sMzvH/Lb/Y+dV8zv4
 bIovMSvLl8qyeAAOcaqNpX/gcHuUSqCvpcHN4BLLnWYPFnIpbWaihxEF5IvLjQ==
To: <baolu.lu@linux.intel.com>
Cc: <dwmw2@infradead.org>, <guojinhui.liam@bytedance.com>, 
	<iommu@lists.linux.dev>, <joro@8bytes.org>, 
	<linux-kernel@vger.kernel.org>, <will@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Thu, 11 Dec 2025 12:17:41 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode
Message-Id: <20251211041741.2132-1-guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <98a2a099-0b90-4837-a20c-742c883e8eea@linux.intel.com>
X-Lms-Return-Path: <lba+2693a45f1+548351+lists.linux.dev+guojinhui.liam@bytedance.com>
References: <98a2a099-0b90-4837-a20c-742c883e8eea@linux.intel.com>

On Thu, Dec 11, 2025 10:10:52AM +0800, Baolu Lu wrote:
> > Since __context_flush_dev_iotlb() is only called on
> > {attach,release}_dev paths (not hot), add pci_device_is_present()
> > there to skip inaccessible devices and avoid the hard-lock.
> >=20
> > Fixes: 37764b952e1b ("iommu/vt-d: Global devTLB flush when present cont=
ext entry changed")
> > Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
>
> Cc: stable@vger.kernel.org
>
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 3e2255057079..b1e8eb6a6504 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -1099,9 +1099,20 @@ int intel_pasid_setup_sm_context(struct device *=
dev)
> >    */
> >   static void __context_flush_dev_iotlb(struct device_domain_info *info=
)
> >   {
> > +	struct pci_dev *pdev;
> > +
> >   	if (!info->ats_enabled)
> >   		return;
> >  =20
> > +	/*
> > +	 * Skip dev-IOTLB flush for inaccessible PCIe devices to prevent the
> > +	 * Intel IOMMU from waiting indefinitely for an ATS invalidation that
> > +	 * cannot complete.
> > +	 */
> > +	pdev =3D dev_is_pci(info->dev) ? to_pci_dev(info->dev) : NULL;
> > +	if (pdev && !pci_device_is_present(pdev))
> > +		return;
>
> Could simply be
>
>	if (dev_is_pci(info->dev) &&
>	    !pci_device_is_present(to_pci_dev(info->dev)))
>		return;
>
> ?
>
> > +
> >   	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
> >   			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
> >  =20

> Thanks,
> baolu

Hi, baolu

Thanks for your time and suggestions.

I=E2=80=99ve sent v2 (https://lore.kernel.org/all/20251211035946.2071-1-guo=
jinhui.liam@bytedance.com/)
with the following changes:

1. Simplified the pci_device_is_present() check in __context_flush_dev_iotl=
b().
2. Added Cc: stable@vger.kernel.org to both patches.

Best Regards,
Jinhui
