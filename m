Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792774850;
	b=Q85irNLUBVsbCFxExQlYHZBscddKBukk+4jIi7tCu/NqtF4dAWc6WN3Uqmq8smIAitYa
	 SgiqvdTCS4pQFjgTgfHePqxl38eyt+cSHg2ENG462Yp/ZNmq4Iku6w713xifLEaGb/wz/
	 84bL0IdIfTHFn2HtZGnRqwKgHO/INK3738ByBsKLnI3Cg5vQ02PTA2dgCW/agA7R9LEEV
	 EZ2Knu6NxYXAlx0hDqQnjvkqndPBb3pqdz5Lyy8UK29deQAyax3BfWaHm7mHWyYXW/sw3
	 Szb6dlsYKcFJzz1vXUp1vAhZyY4b5qFvCx6FT1facMPoiWJgTlxvn32izJtQygqmeAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3p5f3gBnMun549Ua8oc9FqufNrvMp9+KHQM+4uIeziA=;
	b=sAKGriIs8H+j96BOKghZdDd903VCjSHHq5aiXs1TCmI6+mQoooIKmBO/cQCrOFp6xg7v
	 gElN21NH2r/Pm6gICtT3puTxnFwOV3hCl09avJbWNqYf+APoUSs1z/1B+1G7FnTjD8wY7
	 VXPmstgSZnQHfyZr0XONTrGzhT+pUGD6xoq/9m+RW88h971zsMux2T+sSrS29dvXzSPoh
	 o7TJe7lUoq27ON+HKn62HMeFSCUW3/HaSg7NPIJZsHEgJrPjdBEq3VWJBKFyrD7w/pJyf
	 2iUZCCPAnswLpvP7/lxShr2lBiwxKw4M5roI05NjpE+7zFks+Dd8RyLRGusm0giGHYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVOyAns4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E2606A31D
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 17:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B9E2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVOyAns4
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so686645a91.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 10:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792774849; cv=none;
        d=google.com; s=arc-20260327;
        b=Ku10vKm+NJvJaLZ2xdz3GGNP7EwNiFieL17rcymrZvx6egIJF2PMcvLK7pAkrynd+U
         RPtY2Fg44btOZOfpKWjvdg8f90HXA94kYDzvOVJYgsyuGa81RnCEAeSG722zsPkBMIh7
         S4MuvDW5u6SkcGCddOp/yxLUnra8qHEHWIJtH6SRFaWRj1ysTmmc9s24qRSnyis7aIGh
         07QnASw1+pr0NxE3x12uS1zUziVbqZcR87kfM89JHSXFEiYgZK+OhhL6Z/+V8uDAy3qS
         1OoHfcSwvG4yHOxewKa0HKhhaFqQcruSiM7Z8D3ADdHYLEJ9rR4TVZzQ6inh7/hFz+zX
         IRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3p5f3gBnMun549Ua8oc9FqufNrvMp9+KHQM+4uIeziA=;
        fh=rVFH0CyrTiELUuX5uF9xk6GcUAK6WU5okkTPN+wHDcI=;
        b=gpvdAg0tHcns0siRWyXVjfBdAna52KEDQ0ZxsbKfP/0Zv1NgZbrEOWANh7qE20D307
         ISWdEW+1y7EuvZWcpVrEiiN+n9+Vtt8cgOzS8r7sS+XNgVJ2c7xLUEJWmrQwKxxDYIYn
         ZcHiLFe4g4uxUd3uG7s69nVeuoL9uLCTDYNiR9wHg3qS72DNdKb8m3WgwFOudn1yVc3E
         rziyt9YnDPjomrJmABY6qJWaajOyBmnvtB0ZHTK9Ur9TkeaYvASIFej5wtFFkliTgSmB
         NXP9ZMM7vZmk9wWA8prwPCqzFKekpowAJFb9mWKqbMqvcJq7HZv7e/vK6RAta6usOPh9
         D8kw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792774849; x=1793379649; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3p5f3gBnMun549Ua8oc9FqufNrvMp9+KHQM+4uIeziA=;
        b=HVOyAns4PbwnWbFQSft88KlEVmqptDxYIbOXOLAC5IiLz+MkV6iViwXpXr12/H/JNu
         v9kkwr7poF+nqsYClhBVORxC28xJRJKcZ0r7WFLKCBG0axH5O7TYC0WvW7/BVMxA0sqN
         kyMle+YhftmBZCEh7X81LGJkQJ04Jv7P2AnTUU1HZFGx6EcDXLf9T/duhVg4sHaHOJhM
         aRuGGiop8BxyiOMlHJTzAfXPtQJmV/IlS9Au7jC8vAJrGrDut6FwVsjJAWRw/ts2CycD
         y3Zw7Yw/PCNv0jjcwRhxw7Oq/V8RZ8csYXt11f+1MrWzu51Ea3C03A6f2rA9NFjn9Z5G
         TQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774849; x=1793379649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3p5f3gBnMun549Ua8oc9FqufNrvMp9+KHQM+4uIeziA=;
        b=lJi5suv4LE3+/PdkEBPfGfhtc2igZ8N+kAh5/hhii0s07XU1LhH/jPTuE209CB7Lcb
         6WXY8Ttovk/LnYVa/hIYgHPh93Br2zDvMPbte9HAYcaNCe83HLSzgDyq0Ufexe3bsv9k
         6UxLr4q3to4uAWtuT/ABwvRLxKa4SC8Net7m4YUrfLD1B16m/zIO9VcJX8axsALdoSvB
         k229FTl0yNAFuDmmumneHF1FjjLyRklaX0QaC6DRMnCBvnXFACl9cyd/2P9fHaaN6VHE
         fC/VHaGO34iUCPM8UTcM/9q0M1zy/kyEuHedHwEYxJkCELszKl7P9+wloLae+jKV7EIG
         kIwQ==
X-Forwarded-Encrypted: i=1; AKwUvByr8OC4EjWL6giMCNCc2Cc/21qaipVGnPAFSAmz8F+e+AFuqmqMqpXBmS66dZrH68ovhvm5nw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL/TCGBPFhIYWpqPKvPKJhYSTVuoZImhayxtZ/U66l1Mjh3Xsiz
	MqslDzIvl1OWz0WwEpULxZz66xPHZnHn99MtFP6bUwZqL+ycbUR4PifMAehYhjlmkxkVvbCDJPt
	9F56pXIcMeerqld9NTckOGauxn38RSW4=
X-Gm-Gg: AYBFou3EHRSUIwk2R5RoXrUHotD4Z1GnlsMgBE9oXm2ndWEuHbVuvNwqyMGV4uqNG95
	z5DMyC1zgTLCMZ/FTF80vRWjAryg+4XRrI650qELSmMlzYN73kojvn8MOqA42N1CjF4wIyQmV4A
	LDRjleH1ldpB0linWeuJzwHZwIDCrhGw8c+MIt1AuhUtO3Ux2z0v2G5J3rNltwXQRaFesbqhuAY
	82IOuIn5PgOY23x8l5+NZxX1SHlxJ/T6n8DDAnXNg3forr+5XYqzdx/WfWc/BFEvLZjFTVDm80B
	eA7qjgrCyZJ+BQjZBN0nQlAD8Rpf2+Hi8zg6LsOYt1B+9EN+EpaEV8DPkF7hxuQwb+mW0InkB86
	ORgn0/MRekHMCSLAQI9KWt/KCVYnV5PVG2zHe
X-Received: by 2002:a17:90b:2f8b:b0:3ac:a203:e092 with SMTP id
 98e67ed59e1d1-3adce0d002amr2463086a91.1.1792774849076; Fri, 23 Oct 2026
 10:00:49 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261022175408.52254-2-oss.patchbox@gmail.com> <d254f075-74bf-495f-bf88-c8db550ce937@arm.com>
In-Reply-To: <d254f075-74bf-495f-bf88-c8db550ce937@arm.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Fri, 23 Oct 2026 13:00:19 -0400
X-Gm-Features: AclHuK9WgkuyqBzs5NRyCQ6dmaOB7BFiePohFAeP6W3bVOH1efKgR7imYbYABZY
Message-ID: <CAGG=RgAr_Uvdp_OezDsVooYC0h5sK+QzLP=egdJokRTymV1nFg@mail.gmail.com>
Subject: Re: iommu: TLB sync timeouts and page table freeing on unmap
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 11:47, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Yes. If the IOMMU is sufficiently wedged that it's not responding to
> invalidation, there's every chance it's also not processing client
> transactions either. Logging these warnings mainly serves to help
> contextualise related symptoms of the same underlying condition, like a
> client device also reporting errors, or a subsequent register access
> deadlocking entirely.
>
> I can at least speak for arm-smmu-v3 to say that having the timeout
> warnings there has proven useful multiple times in pinpointing hardware
> issues when bringing up platforms on FPGA, but not things that Linux
> itself would ever have to attempt to "handle", or that would ever occur
> on final production hardware.

That makes sense, thanks for explaining. I'll leave these drivers as
they are.

Thanks,
Yuho
