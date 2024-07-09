Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AB80603
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517783; cv=none; b=JJSNtNpf5zeuH2DGQ4iKQl1JM6Y4o79aqMp6kqEyzp8rwbvAu6+RKq3sL1tRWI/vF9Sm54VhkqBgKADds3BV8A6bDM36gNOjt38LouYusgOq1/5T5kzwQBb0odfOCBC5bX2/fbcrvPxL96R9PyQEhD6ZUDiUGfc7VVN4o3Wj4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517783; c=relaxed/simple;
	bh=oqJ+mJ6dM5EbmUcUW5tcynAuL3T4tVBHkDNXFnlAU2M=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=Zss6F7UJKtMwh3A4uNWpFNNgq/lhTDIP4FQL9tzi2XhTr6XBAWu+DlKEWt4Xaw5scj+jl8AguG0PpIlSESQwBrZl+m8DWVIcQk6ouvdxgH8pL/9FoV5q3pl9hN1P4DlpP2K42+f3cw3UeQKIWJOp9L1Un22oj7vMxQdIzJy/j/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eHyu9g6R; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eHyu9g6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720517771; bh=oqJ+mJ6dM5EbmUcUW5tcynAuL3T4tVBHkDNXFnlAU2M=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=eHyu9g6RjxNsivAn+L+TL44+cz0djr+CGiApYeXv9E+LbaZ2s1idRamPhrI2XlZIH
	 4rHTqbxWPTUhDUorXWlIFXdMs5gruwqU/Z55sLExARPr+ST/RzhXFuEP+VXxMELB2H
	 QyShsyFGnzmi8T/CmJ0v+ywNPu0StCjCd9+qVgCg=
Received: from smtpclient.apple ([2408:8207:18a1:c8bf:34:94bd:a685:19f9])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 77A306FB; Tue, 09 Jul 2024 17:29:58 +0800
X-QQ-mid: xmsmtpt1720517398t0xp3eojx
Message-ID: <tencent_F870B162CE439C1B8BF87E0511B4071CF909@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Nob845YVBRs6nw06NN5zgus+jzrRiDE3NY8ArzR3nzwmQqCRaCzs
	 350oLiWVdy1XkLiCP+3Q+sEtRgpwkixUu2T4EoGevgqC8/DFP1XgFsb5Fg5i8XBwot8BnttvKRVo
	 jPgAG0gLgwQteJ8VHK2KEQ5nWT/WxbEYVorDQvnhI5SDkFNpF+BEV+X+iV1bEN4mBQcrKzP5d0lh
	 x7APRPP94sH6Z1o2ezT2eInMavqIMZ8wUaMVJe3Ej8BG6bZvyPoe+WbKwEuWDpYk82t3bd8Pvdjh
	 9EZMn1BOZCwbflwWG+m1Vf0Odr4GhXgqgytXAlwVxI7OOZhQhuqOsMGGHsTO2SR3webomOeN3TcU
	 Hc2+eGQBSllytU0SAUpJ/kCucaR1ptuK4srwHpp5cgQlZc5F7C8e6w4hI7kSi6/QW6YYA4Tc1zRR
	 LIeglbMRsRB30qyCWHBR9X2bMMnDqH5yESi8JTW3kaouaHEv14T35qXCKHV1rstAW3Jy5T4tiUSb
	 DTdi+uaa1HFketSiPNt+IKvnci4xB6rDAKsgh4tj7BvUPudIN8uN3IDhyWPxhjLQSjqqrqGz+t/V
	 OFoWU0lTbzd04BqTJty61Kce+l4Tl6eE0l9ZoGOVTdzH2dj5jfV3NNyFWp2t3RY7DVfG6gTc1TrI
	 fETVh52XNKN5l96Oy18G58z9p2SdvwJ5RjE3+48YRHU2+P4wnf5WSBxrz34/1MiBrWtFQC+ZJZhZ
	 eOg5RJJ9pX5sTEBy10OgX2hlXYXpIqLLnafU0/aHMUK4HOdsyc9T/Gv3/v4vMUtqiOVrrYYuP5lu
	 n9cuv75l2C3a4GDt5XDxpKL1ZVOSsATwzhlOy3kS/7WBU/Y52dREynJSh6tr5R5Q1PTC/PDwq5t+
	 UPTOVefFLq/jSod3lUMW0Tbcwu+FvbdEWwQniVp7T/V/ZFDqvqTMM8lM7Hs6BgsyICzdkGiM2uJX
	 WwW5F1DTo5J9+lMzx+DskqpjXKr55wsF0rk9G5kW9ZIAyFK1ndIQ0oTzaQHpf1p/SnvEMxLU4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH -fixes] dma-direct: only reference arch_dma_set_uncached
 symbol when usable
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
Date: Tue, 9 Jul 2024 17:29:46 +0800
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <317289C5-F247-4C00-B889-E93A1101D1B1@cyyself.name>
References: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
To: iommu@lists.linux.dev
X-Mailer: Apple Mail (2.3774.600.62)

Now, I think fixing in another patch [1] might be better. If that gets =
merged, I think we can ignore this.

[1] =
https://lore.kernel.org/linux-iommu/tencent_A5ED71472ADCAF18F59085464CBE23=
C12A07@qq.com/


