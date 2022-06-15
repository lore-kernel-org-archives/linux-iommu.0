Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C3EC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 14:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6930B61046;
	Wed, 15 Jun 2022 14:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQacAILEif8Q; Wed, 15 Jun 2022 14:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 64B5B61059;
	Wed, 15 Jun 2022 14:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39805C0032;
	Wed, 15 Jun 2022 14:46:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEE3BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 14:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FF3261046
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 14:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3o8cNJ57-FBv for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 14:46:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DB9260D5F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1655304367;
 bh=fO4VIThT2jN8IjrFoYjpk6jSRHO/M4kILno2rNLiA9s=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References;
 b=LBoX6PPlqH0U18Mip7KIjDPw/rYe0b5zpMbCLpk5xJl/4yq96+tuwPFHye8hKzq8w
 xNh5Uhh4/PPfvwA5EtY2oENzYnKgshRDs6vmeBx5zJd2qFitHzNfD0/zcjNDC5VaRB
 ZrugLb/qe1c2R1jPmGuQRRxHTEqQE6zdl9PfYxwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [127.0.0.1] ([217.61.154.5]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1o4VcZ35bh-00825p; Wed, 15
 Jun 2022 16:46:06 +0200
Date: Wed, 15 Jun 2022 16:46:03 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: helping with remapping vmem for dma
User-Agent: K-9 Mail for Android
In-Reply-To: <20220615131700.GA18061@lst.de>
References: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
 <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
 <20220615131700.GA18061@lst.de>
Message-ID: <C81BFF40-13C9-4C7E-BE98-0DAE9221E324@public-files.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:ymi/dNLhID0rFfwSQkIthc5hPryrUBWKoviU/G5LfbZ5hPjWsd8
 RBpykFdP3h0tarGpyZzwg4wXqniI7BpoFqquQLQ/Ce/upW6B44LBGnsD0qaENx9jGlnxPbD
 Ha3g4WzaKMvFvy5NsbcGMPqcWmGqrwoEQdVS/0k9CR0n34CC59yC1JIdW5Te9FhYl7i3gc9
 FRVV++YKgk+rotP7WXFiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E+HnZb1mwbA=:om6cIiNQNYQg16D7bxOOzI
 VB6RwzUENSUhzyLEDKjpUhL/LmxkOF52F77csv/+3tPBsUPLdp4oyMQYVIHfbk/qRjcbF2nro
 +UsaGAKdZgKHGE45sSVdmG/E17Z6Kb7eeAft/ex7uzyK5b3VkH1hWS+xPMqCeaqtRI/fLJwy2
 3WjyGvzIYqMedFEAOtmWIv4PQ83+XGuADRKBvwl2BrEBzMguRsPfNsQnrpfdU1LAganeumFmn
 pYVU4KRkOhlLebuxmdS+j/QmJx/LTvm5QvnYVo0uiuqnjGnDNsbCKLMKhvBYtCmFsfv9x6bPm
 fZAmDi+8SgQYrsonMnhjXki8jKZsR+DsRBduL/tYMWjliJtKgjmFK8oCEygdDVd64HhNbZ6Wf
 YiBRMZveXMm5ie8GdAIlMcadA7esnl1sbwHXXGZC1xXtngS4TMqb47Iiik76fK12MX2YN5pJp
 j0otJfcA5gJeAkfXd9U+zGyErzjvMp1zuj/qN5GSfVY8ZGEcAaXp9TmOf+drr3GBH/NC4KaSD
 WI4aY+PWfxzDcabOSv5tsAW17fsGHbpI4CTcOAb3ZK/OxbFqwbHnUhojIQ1fpyYeNrVPezQdj
 H6KrUrSKJniv62sM/mah8dM+nDZ4hKKG5x08wSGZD1Tj1hYHbR9S0zGoDlVwsWZJMZ+qKedSJ
 imqXDofzpLeZMDjz0x6T4zfBI6+3F9suCHzhy6+vCUib7z2MS1xJe7VY/ac4Rn00H4z9nm1IG
 54jYCoteDtHYO+WgXsioXJg6U1M/yA5lRygr2URUKOBfQ+ObwpzB9epimgxtKjA2awuNx9r+j
 k6vKQOCZHdLH/bKRIa4iuKHEblh6vD8ptMe4tbxugnrS6EMzzDU3Q58Zypkn5TUL+e7EN4EDh
 Trl8TTqFE56O9SQXHvEsEBS6w8j5YZ7w0cxczLILC/zEgJYpDlk8VJW7FBjhQOMl9nFwrck2S
 PV2TvcM3yeWxsuP3x52iO6pqMIUVJS69wa4zRL2Z7jseXl8IJWxq3u1r4Ke14MfftSdRHafij
 ycdgsPadLdvLAX+w0ckZcCuJA/kaUp+BN9Hx+EO+sg6JcBY+T0tjvUHDjVpFuqoc31DnmtGHy
 XAlJgfKP8rVPvHEsmrpGCNZ6ST5WD7sf7Ty42Yz9B/FtuGzT6qjKAXI2A==
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Reply-To: frank-w@public-files.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am 15. Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst.de>:
>On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
>> Put simply, if you want to call dma_map_single() on a buffer, then that 
>> buffer needs to be allocated with kmalloc() (or technically alloc_pages(), 
>> but then dma_map_page() would make more sense when dealing with entire 
>> pages.
>
>Yes.  It sounds like the memory here comes from the dma coherent
>allocator, in which case the code need to use the address returned
>by that and not create another mapping.

As i have not found position where memory is allocated (this is a very huge and dirty driver) is it maybe possible to check if buf is such "allready dma" memory (maybe is_vmalloc_addr) and call dma_single_map only if not (using original buf if yes)?

But i guess it should map only a part of available (pre-allocated) memory and other parts of this are used somewhere else. So i can ran into some issues caused by sharing this full block in different functions.
Hi,

Thanks for first suggestions. 
regards Frank
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
