Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF66C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 08:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 244A381256;
	Thu,  7 Apr 2022 08:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a_pBHetBlafq; Thu,  7 Apr 2022 08:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E494180DD5;
	Thu,  7 Apr 2022 08:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CB49C001D;
	Thu,  7 Apr 2022 08:53:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 761B8C0012;
 Thu,  7 Apr 2022 08:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54B8480DA5;
 Thu,  7 Apr 2022 08:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z03vDUkgmVwZ; Thu,  7 Apr 2022 08:53:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91E5E80D9D;
 Thu,  7 Apr 2022 08:53:37 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2377o8qo019769; 
 Thu, 7 Apr 2022 08:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uyNsE8Ex9YI8S1tXwshKVJTLTCexafBD49QkhLU1s24=;
 b=FIAHZtfeTCueKaFXrFSiIT9mlRhR2N7A9UyZB5RgrAXC+maFHN1717MdP1JqhFOaDibp
 4+Y2xKI7/hfsiKKVoGCGX6uJC0t0T162ThJkE0Y9zefCIQyEg7zHTZHyDhCUiaIfz6XF
 jCMe41zf57d5Y0xYQsBj7BdgvDfx0SBGvssJQCVNrtt19y5F+9TRk9aCSSRSeNf7M56r
 W3E725XQn1PWg6S8lhDPKeXyziP5whMW23+ig4CAqErOnAgqvf+huPCCiTW0vZaRWTOw
 f0W3EiowdEZxHY8Yffo+8eRLunyL7OiDNkVA3X+HjbtfvUGXWoeOEL0XClWot27ZsroZ 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f9uwts6ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Apr 2022 08:53:11 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2378ZRZ7031643;
 Thu, 7 Apr 2022 08:53:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f9uwts6br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Apr 2022 08:53:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2378njqQ008880;
 Thu, 7 Apr 2022 08:53:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma05fra.de.ibm.com with ESMTP id 3f6e48qsa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Apr 2022 08:53:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2378r5OY48496960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Apr 2022 08:53:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A230AE051;
 Thu,  7 Apr 2022 08:53:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52950AE045;
 Thu,  7 Apr 2022 08:53:04 +0000 (GMT)
Received: from sig-9-145-36-59.uk.ibm.com (unknown [9.145.36.59])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  7 Apr 2022 08:53:04 +0000 (GMT)
Message-ID: <49d40d562dbccdac58597b863c357b32f0798284.camel@linux.ibm.com>
Subject: Re: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY
 with dev_is_dma_coherent()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
Date: Thu, 07 Apr 2022 10:53:03 +0200
In-Reply-To: <20220406171729.GJ2120790@nvidia.com>
References: <1-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <db5a6daa-bfe9-744f-7fc5-d5167858bc3e@arm.com>
 <20220406142432.GF2120790@nvidia.com> <20220406151823.GG2120790@nvidia.com>
 <20220406155056.GA30433@lst.de> <20220406160623.GI2120790@nvidia.com>
 <20220406161031.GA31790@lst.de> <20220406171729.GJ2120790@nvidia.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -eI2_i-ijsMVu9WpUqTiTy_ZXGgnAkK_
X-Proofpoint-GUID: d3-YNui-0WOxSLMzaNCj1z5uxlf9oVYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_13,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070043
Cc: Nelson Escobar <neescoba@cisco.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 linux-arm-msm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 Christian Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 2022-04-06 at 14:17 -0300, Jason Gunthorpe wrote:
> On Wed, Apr 06, 2022 at 06:10:31PM +0200, Christoph Hellwig wrote:
> > On Wed, Apr 06, 2022 at 01:06:23PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 06, 2022 at 05:50:56PM +0200, Christoph Hellwig wrote:
> > > > On Wed, Apr 06, 2022 at 12:18:23PM -0300, Jason Gunthorpe wrote:
> > > > > > Oh, I didn't know about device_get_dma_attr()..
> > > > 
> > > > Which is completely broken for any non-OF, non-ACPI plaform.
> > > 
> > > I saw that, but I spent some time searching and could not find an
> > > iommu driver that would load independently of OF or ACPI. ie no IOMMU
> > > platform drivers are created by board files. Things like Intel/AMD
> > > discover only from ACPI, etc.
> > 
> > s390?
> 
> Ah, I missed looking in s390, hyperv and virtio.. 
> 
> hyperv is not creating iommu_domains, just IRQ remapping
> 
> virtio is using OF
> 
> And s390 indeed doesn't obviously have OF or ACPI parts..
> 
> This seems like it would be consistent with other things:
> 
> enum dev_dma_attr device_get_dma_attr(struct device *dev)
> {
> 	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> 	struct acpi_device *adev = to_acpi_device_node(fwnode);
> 
> 	if (is_of_node(fwnode)) {
> 		if (of_dma_is_coherent(to_of_node(fwnode)))
> 			return DEV_DMA_COHERENT;
> 		return DEV_DMA_NON_COHERENT;
> 	} else if (adev) {
> 		return acpi_get_dma_attr(adev);
> 	}
> 
> 	/* Platform is always DMA coherent */
> 	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) &&
> 	    !IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
> 	    !IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) &&
> 	    device_iommu_mapped(dev))
> 		return DEV_DMA_COHERENT;
> 	return DEV_DMA_NOT_SUPPORTED;
> }
> EXPORT_SYMBOL_GPL(device_get_dma_attr);
> 
> ie s390 has no of or acpi but the entire platform is known DMA
> coherent at config time so allow it. Not sure we need the
> device_iommu_mapped() or not.

I only took a short look but I think the device_iommu_mapped() call in
there is wrong. On s390 PCI always goes through IOMMU hardware both
when using the IOMMU API and when using the DMA API and this hardware
is always coherent. This is even true for s390 guests in QEMU/KVM and
under the z/VM hypervisor. As far as I can see device_iommu_mapped()'s
check for dev->iommu_group would only work while the device is under
IOMMU API control not DMA API, no?

Also, while it is true that s390 *hardware* devices are always cache
coherent there is also the case that SWIOTLB is used for protected
virtualization and then cache flushing APIs must be used.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
