Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F7C04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 14:22:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595DD2182B
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 14:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595DD2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2CF2218C5;
	Mon, 27 May 2019 14:22:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E388F1858
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 14:21:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 813386C5
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 14:21:46 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 46D282AF; Mon, 27 May 2019 16:21:44 +0200 (CEST)
Date: Mon, 27 May 2019 16:21:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v7 1/1] iommu: enhance IOMMU dma mode build options
Message-ID: <20190527142140.GH8420@8bytes.org>
References: <20190520135947.14960-1-thunder.leizhen@huawei.com>
	<20190520135947.14960-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190520135947.14960-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-ia64 <linux-ia64@vger.kernel.org>,
	Sebastian Ott <sebott@linux.ibm.com>,
	linux-doc <linux-doc@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
	linux-s390 <linux-s390@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, x86 <x86@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Will Deacon <will.deacon@arm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Robin Murphy <robin.murphy@arm.com>
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

Hi Zhen Lei,

On Mon, May 20, 2019 at 09:59:47PM +0800, Zhen Lei wrote:
>  arch/ia64/kernel/pci-dma.c                |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
>  arch/s390/pci/pci_dma.c                   |  2 +-
>  arch/x86/kernel/pci-dma.c                 |  7 ++---
>  drivers/iommu/Kconfig                     | 44 ++++++++++++++++++++++++++-----
>  drivers/iommu/amd_iommu_init.c            |  3 ++-
>  drivers/iommu/intel-iommu.c               |  2 +-
>  drivers/iommu/iommu.c                     |  3 ++-
>  8 files changed, 48 insertions(+), 18 deletions(-)

This needs Acks from the arch maintainers of ia64, powerpc, s390 and
x86, at least.

It is easier for them if you split it up into the Kconfig change and
separete patches per arch and per iommu driver. Then collect the Acks on
the individual patches.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
