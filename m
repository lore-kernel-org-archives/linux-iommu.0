Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA46C4332F
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 13:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60DAB60F92;
	Tue, 15 Feb 2022 13:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kh1N8c0RCSYK; Tue, 15 Feb 2022 13:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23F3960F6F;
	Tue, 15 Feb 2022 13:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE997C001A;
	Tue, 15 Feb 2022 13:00:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9F2BC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 13:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7AD04093F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 13:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RqneqKbbsEfb for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 13:00:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CC2A4055D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 13:00:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D5FE6616D6;
 Tue, 15 Feb 2022 13:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D88C340EB;
 Tue, 15 Feb 2022 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644930054;
 bh=rBQWeVT+EjzsgM3r1Lc4uCaVLYnzGjhTjj/msDXK3JQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Krj7P+C91g6qOvjxvKB81mvkRoyrAHTF2oSPNlKRcBJo6UzBrK7m9Qlspp+bE8L60
 XCQxx4QeOVrwnNgvEJ86FjQZg7CL9v5KzzXIYET+suGKDkot+JLR+jgRJgrDF8PHXb
 y8zl/wECo6oZ0t040D0GT8hit88BtxAcseq6Nt54m60DPgh6P+Wc7CDmPmCCQirWT6
 /bhPJTdJme5BWgevr8q2KdY9PycccGncoMNM4ZarxRXa6gIzXof5emg7hWNjzMo6+z
 8OapdOtjag5MQHSESLH0Mvw9rq7Q9xmSOPi/qCAVtsiX7TXBH/kk03l0SaDjMWwS86
 AStehWQJl8CIg==
Date: Tue, 15 Feb 2022 13:00:44 +0000
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Message-ID: <20220215130044.GA7154@willie-the-truck>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, Yicong Yang <yangyicong@hisilicon.com>,
 daniel.thompson@linaro.org, peterz@infradead.org, mingo@redhat.com,
 helgaas@kernel.org, liuqi115@huawei.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com, coresight@lists.linaro.org, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org, robin.murphy@arm.com
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

On Mon, Feb 14, 2022 at 08:55:20PM +0800, Yicong Yang wrote:
> On 2022/1/24 21:11, Yicong Yang wrote:
> > The DMA of HiSilicon PTT device can only work with identical
> > mapping. So add a quirk for the device to force the domain
> > passthrough.
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 6dc6d8b6b368..6f67a2b1dd27 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
> >  	}
> >  }
> >  
> > +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
> > +					 (pdev)->device == 0xa12e)
> > +
> > +static int arm_smmu_def_domain_type(struct device *dev)
> > +{
> > +	if (dev_is_pci(dev)) {
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +		if (IS_HISI_PTT_DEVICE(pdev))
> > +			return IOMMU_DOMAIN_IDENTITY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct iommu_ops arm_smmu_ops = {
> >  	.capable		= arm_smmu_capable,
> >  	.domain_alloc		= arm_smmu_domain_alloc,
> > @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
> >  	.sva_unbind		= arm_smmu_sva_unbind,
> >  	.sva_get_pasid		= arm_smmu_sva_get_pasid,
> >  	.page_response		= arm_smmu_page_response,
> > +	.def_domain_type	= arm_smmu_def_domain_type,
> >  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> >  	.owner			= THIS_MODULE,
> >  };
> > 
>
> Is this quirk ok with the SMMU v3 driver? Just want to confirm that I'm on the
> right way to dealing with the issue of our device.

I don't think the quirk should be in the SMMUv3 driver. Assumedly, you would
have the exact same problem if you stuck the PTT device behind a different
type of IOMMU, and so the quirk should be handled by a higher level of the
stack.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
