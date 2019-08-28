Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2826C3A5A1
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 16:42:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FFA208C2
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 16:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FFA208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F22963303;
	Wed, 28 Aug 2019 16:42:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E518F32E4
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 16:41:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CC579756
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 16:41:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Aug 2019 09:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; d="scan'208";a="380462397"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
	by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2019 09:41:47 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
	ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 28 Aug 2019 09:41:46 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
	ORSMSX116.amr.corp.intel.com ([169.254.7.63]) with mapi id
	14.03.0439.000; Wed, 28 Aug 2019 09:41:46 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] x86/pci: Add a to_pci_sysdata helper
Thread-Topic: [PATCH 2/5] x86/pci: Add a to_pci_sysdata helper
Thread-Index: AQHVXasMRGGSFfOeWEC6h3pcJWlJsKcROPeA
Date: Wed, 28 Aug 2019 16:41:45 +0000
Message-ID: <809ad38b6aca8e828db7be6423cb03ac9208fb5a.camel@intel.com>
References: <20190828141443.5253-1-hch@lst.de>
	<20190828141443.5253-3-hch@lst.de>
In-Reply-To: <20190828141443.5253-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.6.7]
Content-ID: <F4FADED671890B4DA25C0EC95EBE283D@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
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

On Wed, 2019-08-28 at 16:14 +0200, Christoph Hellwig wrote:
> Various helpers need the pci_sysdata just to dereference a single field
> in it.  Add a little helper that returns the properly typed sysdata
> pointer to require a little less boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/pci.h | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 6fa846920f5f..75fe28492290 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -35,12 +35,15 @@ extern int noioapicreroute;
>  
>  #ifdef CONFIG_PCI
>  
> +static inline struct pci_sysdata *to_pci_sysdata(struct pci_bus *bus)
Can you make the argument const to avoid all the warnings from callers
passing const struct pci_bus

snip
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
