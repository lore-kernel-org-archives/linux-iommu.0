Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D350FC432C3
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 19:12:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA88A20870
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 19:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOoHu5Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA88A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 737BC203E5;
	Wed, 27 Nov 2019 19:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AmNeLrg7TqyE; Wed, 27 Nov 2019 19:12:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F6B6203D0;
	Wed, 27 Nov 2019 19:12:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64EF4C1DDA;
	Wed, 27 Nov 2019 19:12:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B55AC0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4258486F87
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:12:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h9FuBiTGe3GT for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 19:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 37EA286E88
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:12:27 +0000 (UTC)
Received: from localhost (unknown [5.29.147.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0161920835;
 Wed, 27 Nov 2019 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574881946;
 bh=Kf/5NxHVSIFobJHUMSeX3+TDTrwFmhqNDPHnh0UqOdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dOoHu5JumTuxbJrzjRT3hV4JQEzObfh08t9Z+gODcqAdZKzTi4Eu2kHYBAqXfytVF
 nx4i0mymUmYUqUxEpczT4vsroGXuejjIhI9UFlrKBajfdiZ6vo416fak1GdlKtMrhH
 gHlhrhf3LFVTjSrZaGYZziBl9P1P1NEba5MVXgvk=
Date: Wed, 27 Nov 2019 21:12:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/7] linux/log2.h: Add roundup/rounddown_pow_two64()
 family of functions
Message-ID: <20191127191223.GF10331@unreal>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
 <20191126091946.7970-2-nsaenzjulienne@suse.de>
 <20191126125137.GA10331@unreal>
 <6e0b9079-9efd-2884-26d1-3db2d622079d@arm.com>
 <b30002d48c9d010a1ee81c16cd29beee914c3b1d.camel@suse.de>
 <c08863a7-49c6-962e-e968-92adb8ee2cc9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c08863a7-49c6-962e-e968-92adb8ee2cc9@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Hanjun Guo <guohanjun@huawei.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 f.fainelli@gmail.com, linux-rockchip@lists.infradead.org,
 linux-rdma@vger.kernel.org, maz@kernel.org, phil@raspberrypi.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 mbrugger@suse.com, netdev@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, wahrenst@gmx.net, james.quinlan@broadcom.com,
 Sudeep Holla <sudeep.holla@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Tariq Toukan <tariqt@mellanox.com>
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

On Wed, Nov 27, 2019 at 07:06:12PM +0000, Robin Murphy wrote:
> On 27/11/2019 6:24 pm, Nicolas Saenz Julienne wrote:
> > On Wed, 2019-11-27 at 18:06 +0000, Robin Murphy wrote:
> > > On 26/11/2019 12:51 pm, Leon Romanovsky wrote:
> > > > On Tue, Nov 26, 2019 at 10:19:39AM +0100, Nicolas Saenz Julienne wrote:
> > > > > Some users need to make sure their rounding function accepts and returns
> > > > > 64bit long variables regardless of the architecture. Sadly
> > > > > roundup/rounddown_pow_two() takes and returns unsigned longs. Create a
> > > > > new generic 64bit variant of the function and cleanup rougue custom
> > > > > implementations.
> > > >
> > > > Is it possible to create general roundup/rounddown_pow_two() which will
> > > > work correctly for any type of variables, instead of creating special
> > > > variant for every type?
> > >
> > > In fact, that is sort of the case already - roundup_pow_of_two() itself
> > > wraps ilog2() such that the constant case *is* type-independent. And
> > > since ilog2() handles non-constant values anyway, might it be reasonable
> > > to just take the strongly-typed __roundup_pow_of_two() helper out of the
> > > loop as below?
> > >
> > > Robin
> > >
> >
> > That looks way better that's for sure. Some questions.
> >
> > > ----->8-----
> > > diff --git a/include/linux/log2.h b/include/linux/log2.h
> > > index 83a4a3ca3e8a..e825f8a6e8b5 100644
> > > --- a/include/linux/log2.h
> > > +++ b/include/linux/log2.h
> > > @@ -172,11 +172,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
> > >     */
> > >    #define roundup_pow_of_two(n)			\
> > >    (						\
> > > -	__builtin_constant_p(n) ? (		\
> > > -		(n == 1) ? 1 :			\
> > > -		(1UL << (ilog2((n) - 1) + 1))	\
> > > -				   ) :		\
> > > -	__roundup_pow_of_two(n)			\
> > > +	(__builtin_constant_p(n) && (n == 1)) ?	\
> > > +	1 : (1UL << (ilog2((n) - 1) + 1))	\
> >
> > Then here you'd have to use ULL instead of UL, right? I want my 64bit value
> > everywhere regardless of the CPU arch. The downside is that would affect
> > performance to some extent (i.e. returning a 64bit value where you used to have
> > a 32bit one)?
>
> True, although it's possible that 1ULL might result in the same codegen if
> the compiler can see that the result is immediately truncated back to long
> anyway. Or at worst, I suppose "(typeof(n))1" could suffice, however ugly.
> Either way, this diff was only an illustration rather than a concrete
> proposal, but it might be an interesting diversion to investigate.
>
> On that note, though, you should probably be using ULL in your current patch
> too.
>
> > Also, what about callers to this function on platforms with 32bit 'unsigned
> > longs' that happen to input a 64bit value into this. IIUC we'd have a change of
> > behaviour.
>
> Indeed, although the change in such a case would be "start getting the
> expected value instead of nonsense", so it might very well be welcome ;)

Agree, if code overflowed with 32 bits before this change, the code was already
broken. At least now, it won't overflow.

>
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
