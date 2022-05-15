Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA5C433F5
	for <iommu@archiver.kernel.org>; Sun, 15 May 2022 10:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DACA81970;
	Sun, 15 May 2022 10:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PxSupWIHXd4R; Sun, 15 May 2022 10:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5781D81934;
	Sun, 15 May 2022 10:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20AADC0039;
	Sun, 15 May 2022 10:35:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDDC0C002D
 for <iommu@lists.linux-foundation.org>; Sun, 15 May 2022 10:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5B724087C
 for <iommu@lists.linux-foundation.org>; Sun, 15 May 2022 10:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xn9tnhShNIfH for <iommu@lists.linux-foundation.org>;
 Sun, 15 May 2022 10:35:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F6D44087A
 for <iommu@lists.linux-foundation.org>; Sun, 15 May 2022 10:35:46 +0000 (UTC)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
 id CDF9C26EA99; Sun, 15 May 2022 12:35:44 +0200 (CEST)
Date: Sun, 15 May 2022 12:35:44 +0200
From: Janne Grunau <j@jannau.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 0/5] iommu: Support mappings/reservations in
 reserved-memory regions
Message-ID: <20220515103544.GC26732@jannau.net>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512190052.1152377-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Sameer Pujar <spujar@nvidia.com>,
 asahi@lists.linux.dev
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

Hej,

I'm working on the display controller for Apple silicon SoCs and will 
add some comments with support for it in mind.

added asahi@lists.linux.dev to CC for the Apple silicon related aspects

On 2022-05-12 21:00:47 +0200, Thierry Reding wrote:
> 
> this is another attempt at solving the problem of passing IOMMU
> configuration via device tree. It has significantly evolved since the
> last attempt, based on the discussion that followed. The discussion can
> be found here:
> 
>   https://lore.kernel.org/all/20210423163234.3651547-1-thierry.reding@gmail.com/
> 
> Rather than using a memory-region specifier, this new version introduces
> a new "iommu-addresses" property for the reserved-memory regions
> themselves.

If experimented with both proposed bindings for dcp and I think this 
binding is easer to understand and to work with.

> These are used to describe either a static mapping or
> reservation that should be created for a given device. If both "reg" and
> "iommu-addresses" properties are given, a mapping will be created
> (typically this would be an identity mapping)

dcp on Apple silicon will not use identity mappings. The IOMMU supports 
identity mapping but the pre-configured mappings setup by Apple's system 
firmware will not work with identity mapping. It maps multiple regions 
which are incompatible with a linear identity mapping. In addition the 
embbeded aarch64 micro controllers used in the display subsystem appears 
to use a heap mapped at low IOVA space starting at 0.

> whereas if only an "iommu-addresses" property is specified, a 
> reservation for the specified range will be installed.
> 
> An example is included in the DT bindings, but here is an extract of
> what I've used to test this:
> 
> 	reserved-memory {
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		ranges;
> 
> 		/*
> 		 * Creates an identity mapping for the framebuffer that
> 		 * the firmware has setup to scan out a bootsplash from.
> 		 */
> 		fb: framebuffer@92cb2000 {
> 			reg = <0x0 0x92cb2000 0x0 0x00800000>;
> 			iommu-addresses = <&dc0 0x0 0x92cb2000 0x0 0x00800000>;
> 		};

The binding supports mapping the same region to multiple devices. The 
code supports that and it will be used on Apple silicon. Not necessary 
to extend and complicate the example for I wanted to mention it 
explicitly.

> 
> 		/*
> 		 * Creates a reservation in the IOVA space to prevent
> 		 * any buffers from being mapped to that region. Note
> 		 * that on Tegra the range is actually quite different
> 		 * from this, but it would conflict with the display
> 		 * driver that I tested this against, so this is just
> 		 * a dummy region for testing.
> 		 */
> 		adsp: reservation-adsp {
> 			iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00010000>;
> 		};
> 	};
> 
> 	host1x@50000000 {
> 		dc@54200000 {
> 			memory-region = <&fb>, <&adsp>;
> 		};
> 	};
> 
> This is abbreviated a little to focus on the essentials. Note also that
> the ADSP reservation is not actually used on this device and the driver
> for this doesn't exist yet, but I wanted to include this variant for
> testing, because we'll want to use these bindings for the reservation
> use-case as well at some point.
> 
> Adding Alyssa and Janne who have in the past tried to make these
> bindings work on Apple M1. Also adding Sameer from the Tegra audio team
> to look at the ADSP reservation and double-check that this is suitable
> for our needs.

The binding itself is sufficient for the needs of the display subsystem 
on Apple silicon. The device tree parsing code for reserved regions is 
of limited use in it's current form. We will have either to extend or 
duplicate it to retrieve the non-identity mappings. That's our problem 
to solve.

Janne
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
