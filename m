Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1628C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8386D60E1D;
	Fri, 17 Dec 2021 08:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Q6l9MSVtsV0; Fri, 17 Dec 2021 08:31:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FB6961022;
	Fri, 17 Dec 2021 08:31:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71601C002F;
	Fri, 17 Dec 2021 08:31:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93CD7C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7363561022
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HYKtWxSG-bJg for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 08:31:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6E6660DF9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:31:18 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D6B4536D; Fri, 17 Dec 2021 09:31:16 +0100 (CET)
Date: Fri, 17 Dec 2021 09:31:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
Message-ID: <YbxK01SEvBeCTqO8@8bytes.org>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
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

On Tue, Nov 23, 2021 at 06:10:33PM +0200, Maxim Levitsky wrote:
> Maxim Levitsky (5):
>   iommu/amd: restore GA log/tail pointer on host resume
>   iommu/amd: x2apic mode: re-enable after resume
>   iommu/amd: x2apic mode: setup the INTX registers on mask/unmask
>   iommu/amd: x2apic mode: mask/unmask interrupts on suspend/resume
>   iommu/amd: remove useless irq affinity notifier
> 
>  drivers/iommu/amd/amd_iommu_types.h |   2 -
>  drivers/iommu/amd/init.c            | 107 +++++++++++++++-------------
>  2 files changed, 58 insertions(+), 51 deletions(-)

Applied for v5.17, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
