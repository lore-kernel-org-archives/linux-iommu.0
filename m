Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C2C31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 07:19:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11EC2171F
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 07:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11EC2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8C21A8DC;
	Thu, 15 Aug 2019 07:19:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1642E8BF
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 07:19:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A67E67F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 07:19:57 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 027072F9; Thu, 15 Aug 2019 09:19:54 +0200 (CEST)
Date: Thu, 15 Aug 2019 09:19:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 06/10] iommu: Remember when default domain type was set
	on kernel command line
Message-ID: <20190815071954.GD22669@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
	<20190814133841.7095-7-joro@8bytes.org>
	<754a526e-a6d4-8a3f-0b35-9dd3def5d24b@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <754a526e-a6d4-8a3f-0b35-9dd3def5d24b@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	corbet@lwn.net, Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
	Thomas.Lendacky@amd.com, hpa@zytor.com, tglx@linutronix.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hey Lu Baolu,

thanks for your review!

On Thu, Aug 15, 2019 at 01:01:57PM +0800, Lu Baolu wrote:
> > +#define IOMMU_CMD_LINE_DMA_API		(1 << 0)
> 
> Prefer BIT() micro?

Yes, I'll change that.

> > +	iommu_set_cmd_line_dma_api();
> 
> IOMMU command line is also set in other places, for example,
> iommu_setup() (arch/x86/kernel/pci-dma.c). Need to call this there as
> well?

You are right, I'll better add a 'bool cmd_line' parameter to the
iommu_set_default_*() functions and tell the IOMMU core this way. That
will also fix iommu=pt/nopt.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
