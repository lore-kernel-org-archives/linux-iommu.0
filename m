Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816756;
	b=jZ5YLUkGuf23nf0yUt4NkGoDk+OsghE9JTN6sZUXRdUU7zvSMh1DsWRcJeXT49LktG1n
	 oeiodCmNTscgQKnsfmcusQpQlG5IjbLZScJmJdvsBy3fI973vH4XEqRFiqqO2/WkzKUSd
	 z99zkx2uDww9s4NRLRuGIyErmbOT+8MaPoeFW2NtUi3GFEa4R6Si6DFpvc0Hxzp2vBQvZ
	 r647zkFFnnEjkfepzrQJ0tDeH4iHd3mc+M+7Q11T0L7u1hLAybUqm/uzJSYqA3ZBdY3/k
	 6MgBEnUWxJIP3F9nuXckn+8Z7zko0mNfGfybAniSBusGBGBZiUY0NIGGltFAbIeJ4yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816756;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qnNiZniQ7hU/5TWkcm4nRDnYdoUdBrV52jNGrhHKE60=;
	b=jT1iBlo1zg4lTYRBOkn6A7FZJRJ4mckqmX6LGw00ECUZ51R2p7z5JY7R1+9xeXZKkWuq
	 qZ85oL9bXyiIb2kZ2mgK7BPnVHCMuAPC0DOF+f98SkAekGGtKHnuYcIJmrqFQMG2VdAwA
	 Xx+Utqm4K+Rc7PRVbzdyoAu1aGFK4aggZvtuyLq2bGHfc9aan7989L9Cgo2fkNgM77RmR
	 SoF4MGjjvz8aB0CSAmPd8nU7bq6wT9IandAfC2JsYx2XBdCDgKBvtQTOjHz2MA0i6bbtf
	 ikKtsj8wtm6KoMrwiZrTC0ZMsSTM9/AqK4WKGDiSK/Jm5pjUhMO5BojHFGHNg7q9RgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Tg7GJN8V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27287606A33F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 08:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27287606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Tg7GJN8V
ARC-Seal: i=1; a=rsa-sha256; t=1794816753; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A532Ekd+Z2KsibURE7m1nmvLs513y7ECYzW+jU413ILxQ0XEirO/uNZRNWRDJMryciASh2hXEw+mFskk1wlJHsNWcPDTQIaUcXuojMu6wdg8qBv/UUuiJJMV1wMt00USf9J/wE8M6XVRzJjqqWAExMCKWNo3KzBEmiBYHrqm5Ck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794816753; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qnNiZniQ7hU/5TWkcm4nRDnYdoUdBrV52jNGrhHKE60=; 
	b=ktg3NpXwjvTLmAwoCah4C/MMhMZRPn8fkt3OFd2o3X7y6q3BUk0l1YTdz7dH5sklazeDk+eF3mIgqM7SJCXE1dM49Lzqq3chGiS+C8cL1BaofJB202vgIkEhE+CmhUQDaRiIyXRxhrMaoEKfBd8tXDYum/wejO+exHxYPpezFfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Tg7GJN8V9orHnn3nGD2SqAtPDe8zQI5S9EytKgr6QkrMt/3fyTMFK5wnQIY9wzjnkYJoCPba0aIiGVcSbXCId5cenXQJwHZRuQvikZ/RQazcOSeGuB4ggapXs5+W+QFTuIa7unoazV9sFLNGxbqbrsJygCbRhLK/CS2bXXWSfH8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=qnNiZniQ7hU/5TWkcm4nRDnYdoUdBrV52jNGrhHKE60=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794816752585120.90548357908153;
	Mon, 16 Nov 2026 00:12:32 -0800 (PST)
Message-ID: <a1eb584f-abf1-4213-b27c-dbda8c18df4e@collabora.com>
Date: Mon, 16 Nov 2026 09:12:29 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vsi: Don't write the enable register on suspend
To: aiyengar1990@gmail.com, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261113-vsi-iommu-disable-v1-1-94f7f44540b3@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261113-vsi-iommu-disable-v1-1-94f7f44540b3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 13/11/2026 à 21:06, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> Benjamin Gaignard pointed out that, per the IOMMU documentation, the
> IOMMU can't be disabled once enabled. Drop the write on suspend:
> resume reprograms the IOMMU anyway.
>
> Suggested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
> Benjamin suggested this in the hantro-robust review:
> https://lore.kernel.org/r/f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com
>
> Identity attach keeps the write. On RK3588 it does clear the enable
> bit (AHB_CONTROL reads 0x1 before, 0x0 after), and without it the
> IOMMU would keep using the old domain's page table. Benjamin, should
> that one go too?
>
> Tested on RK3588S (Orange Pi 5), v7.3-based kernel with [1] and
> hantro-robust v3 [2]: AV1 fluster unchanged (203/242), 20 AV1 decoder
> unbind/bind cycles, 3 s2idle cycles. The IOMMU runtime suspended
> after each step; no SError or IOMMU fault.
> Not tested: identity domains, suspend to RAM.
> No conflict with [1] or with patch 10 of [2].
>
> Developed with Claude (Anthropic), which wrote the code and the commit
> message. I reviewed it.
>
> [1] https://lore.kernel.org/r/20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com
> [2] https://lore.kernel.org/r/20261113-hantro-robust-v3-0-82383c722ad2@gmail.com
> ---
>   drivers/iommu/vsi-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 5dac20b143a5..bd984060253b 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -740,7 +740,7 @@ static int __maybe_unused vsi_iommu_suspend(struct device *dev)
>   {
>   	struct vsi_iommu *iommu = dev_get_drvdata(dev);
>   
> -	vsi_iommu_disable(iommu);
> +	iommu->enable = false;
>   
>   	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>   
>
> ---
> base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
> change-id: 20261113-vsi-iommu-disable-42edd626d009
>
> Best regards,
> --
> Arun Iyengar <aiyengar1990@gmail.com>
