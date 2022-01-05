Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEC5C433EF
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 14:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A098C82F03;
	Wed,  5 Jan 2022 14:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XR2CbMrH11UJ; Wed,  5 Jan 2022 14:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83798813BC;
	Wed,  5 Jan 2022 14:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5225CC0030;
	Wed,  5 Jan 2022 14:12:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E66FC001E
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 14:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43FD460BAC
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 14:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h7hcZi8MeHzq for <iommu@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 14:12:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A6FD60BA1
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=U4D7oTRxepQOIql+A0wdB71kxH0W4D69D2V8aoqf7ho=; b=YyG9hhbl3dS9oFB+zugcelrgKa
 VHt1ImGiM3IXoOweYcNA/TxtXsAvZNLhGkAAEB8HafztA8F8j/N1YoRMFgd1a/AQ977pedzl7mToK
 0YHj6qtVPo8ekeC3I90UJjZE7gMr7uD7VKlJMsNiUgQFHPF/h2xQ4qd8u7x9ZNYsvpPaMhsq6T+Ce
 uY2Q3lo1Q7e52JW9qzq4QywowJu0zo7PwGEsECGsHgfHcLt+otva5gGRbwlkFnYFAbZ15EADSTraU
 AD+xqlCOv3bMZBJGNlGcz1YabmZQ9TvggFhwPqJJsNGYQxpw/cvL33R4uZ51HOBYW3MIDPiJ0xfi1
 MF5df9oQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n571m-00ExQg-Td; Wed, 05 Jan 2022 14:12:34 +0000
Date: Wed, 5 Jan 2022 06:12:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: Memory clearing in swiotlb_update_mem_attributes()
Message-ID: <YdWnUmJsjPUYiycV@infradead.org>
References: <20220104224939.yhpceiuzqqhb72ql@box.shutemov.name>
 <d16046ad-7828-a015-b6a3-3ed01ed15bac@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d16046ad-7828-a015-b6a3-3ed01ed15bac@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, iommu@lists.linux-foundation.org
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

On Wed, Jan 05, 2022 at 08:06:10AM -0600, Tom Lendacky wrote:
> On 1/4/22 4:49 PM, Kirill A. Shutemov wrote:
> > Hi Tom,
> > 
> > For larger TDX VM, memset() after set_memory_decrypted() in
> > swiotlb_update_mem_attributes() takes substantial portion of boot time.
> > 
> > It makes me wounder why do we need it there? Malicious VMM can mess with
> > decrypted/shared buffer at any point and for normal use it will be
> > populated with real data anyway.
> > 
> > Can we drop it?
> 
> Probably more a question for Christoph. Does SWIOTLB need to be initialized
> to zeroes? If it does, then the memset after the set_memory_decrypted() is
> required, otherwise it will appear as ciphertext to SWIOTLB.

While the traditional swiotlb initialization zeroes it I can't really
see any reason why we would want to zero it.  If we really care about
not leaking data to the device we'd need to zero the padding at mapping
time.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
