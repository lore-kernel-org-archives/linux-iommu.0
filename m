Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551D528423
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688145; cv=pass; b=od4clNtfsvtVihf70fEEevD+Sxj7g0Kuizw2GE4NndbvMzwQtnCJ4+niasZzDptp/DCKl2yFrKer+L9AgCOi4R6+h+qEyXOGkL5y/VLKaIDVca1POQYv5Wu+AQhpbFKJhq66so0UeKRT2B25GfWhzVDVn21gHIj3G14ze5beeNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688145; c=relaxed/simple;
	bh=9kGGIoKUXsVY33zGMSg04jYAL3JPXU1LBRMzAUAEyQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk47+5YHlyzpNuyvY/2EgU31NwwN51VU7kKpw50zzhjzLCgzfeNMR/e8OvdXHCNRofsOQtEbPuEwlFOPWkonquGmyZ/qxb1D38GlCJOi3orY5nQ5ryiWZm3z9nbAuglfwNxOutcGaeQqeIqtPQ5MDN02h9KVeM2QlLhnLsf0Jv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDhdp6JA; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDhdp6JA"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so5483482eec.0
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 06:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688143; cv=none;
        d=google.com; s=arc-20260327;
        b=p0tQVO608saRK8HfMQFUqwjt7NAyBdF9LQQbRlfxDoFLbT+7TB/Quwp52SbKi3w1Z2
         +3aeDXl2+vL8BuNARkhxsNXTCngkhHdp7ncRLRINqV5Bfd0RjCpnnaWY8gyCSemhonqA
         2aXbaIpJ4VcXhpwvDrxrWalkDKT4EAK0RE35W/9t6MHG7mFWQUxIzsvYeZnUtW8u1MlF
         iSmZ3qkMw426TXvzNOVkrXSIgUOg7G9AgrF5mjukfm/EPQpG0yqZKNY+OkD3o2hw26JN
         CCPnag3FU8dP5LXukaLcbjHj9L/XcAcqNaGtzk/I/bhQZGwrEWjB8pT2xV3r2QVWXhDL
         zQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=;
        fh=bzsedhy8MEDxOZm+dhwOlAYriBadDk2PSk4oQltDGI8=;
        b=RfkBQaFW+LYd07FV511+5SQ3MqqRW+EcWxgEay5CcQq6j50ghUxg/WsCthHmFXAbVk
         dfTUWsnLAwNgAD3+rVNXWQut5rXMU+ZUotmS4HxF8ySAV4YhkATACa4BIz0b+d7Wc20j
         hbyMXAoyT1a8kVtWE+yMyfef6wMmDtsVhhMTZWEiBlV1EA3KXRJbQnqmypchP3Ru+9nA
         yjXjIKYwlbNdM+1zOCAPhpRGR0NN/Y48TNSfgKhXOn0uw6NMvX8rmmgeNLPoz6UVPvzx
         mT81K+ufmrU3bbzjby6xQO31eGijgbnfhHRbQflJ7z++muJklQKPKWwVmfORsMFpuXE+
         YWsw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790688143; x=1791292943; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=;
        b=gDhdp6JAKj6QTkZjkm2qdqpzpVxS6TnTQv1X8kN0FBQxKAyJIOnlTT8Nkxr/nsKu5I
         0y4wr19SMoVvtpxxMaahJIVqn/vAU25rt6jsQ6x3TDn8m5NH5KLW9D/lXrzfIIkM+K4L
         EPYFudU5cUyrMNgfhhIT8z1sdmCSe/95PT58v5OedbueQEraCjxg/P+W+NHTz2V4y/cW
         ov+Hdg1kPaWyqkEFdji/W+WtCwem5DUL6IFfagcKBZ3TXXL1U5TLmMnkenwcilBfpmwl
         gkTpXTsgNGz+nJipiAn+N5nJko98FVdf3mDkjiAYJ1dsV0eWV0FPtx+jrfnhzmWiNKym
         s4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688143; x=1791292943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=;
        b=LMyb8YO6+xKtbbZuriXfL2j3bUdFbtfVJJjUAaHZFDfBDg3XCIcngZvjGHoWmy4doy
         aNZOMHUcrg40lqkXAZAcygVqEGcfNs+u33PP5WsyC7mZ6v9zq4mW5LxkNNkVAR21/rgG
         X/5giYuOwnieD8woS4Sjf9wproMMhMwfZ39sx32axUYwcU1xGoKFZuF0EhirejQzS9CU
         n69wu6HgpqFYUL+r13LOYgbOWvR22KX7tkXcUiqaomQ5raNGy9wdyVevqmiF+12Kj96M
         IFAxxXwAmhiAgjYbjoQwGFmgnPfLQerRTKMeEe4+BJ44cyQDfuAYu6fnBZmT0bSZdbDb
         tgug==
X-Forwarded-Encrypted: i=1; AKwUvBwlWqpD8DnQ8wnp0SixPkumS4+AX+G4Qoqw9cxMYPZicvCvbe9U0m9AVhWiTTUetRaBylkACQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKr04xOD8yGp0grNTfmkC/kGLQjU6FSDUn6hFvf3QH7ODNLYxyZ
	7RjO7HKAGDEr7UDYPOFWqIB0RVLU8seIbnZ/dG5abqcQvco7KACWLIwYh6hUktlVZZDkfe7yKwm
	YH6RHTyFgCDkKW8k0/ELGCmW25noBNrM=
X-Gm-Gg: AYBFou0q6J5KpW06ewOVtDKCJmxAV8O+m60xN2N+E/mA7r2Q0W4KlHAZHFZ7/gZo9mY
	/qjq0HDI4RikVygKVjpPqESwhY6HrTJJP6CLutezkbaqSBnCiCuCRJlmMON1jn3UqawPvBuEzgr
	8bZxgzUExvGIxo1UsF7mCqPObKbe+sJa1S0WlAcwLeTtYzxq/vDwsrrcd8KqM+6JCuVhQ4V3sUu
	Mg+dBdBZqvQ8jgEFRyEt3sa/FfsLacvFUfwwy2dLAB4rF7MeMyWs1yn22hOWnzpWhNcZP7PFFVH
	HXm6IY3eg9rVEiz/NJqfSavfb5OtUDTm6QkvkEXv0h9SccF47+Drn4geegHyMFyXYd8oFcY8HbG
	T2WD899PPuBSYW/c5zuYeIEUPcCS5nt75z688UyPNCLCnpjiTORzr7ZOgcSSMBRzFWyLLjjDekc
	+oNC9NcLDsBU19ziVZqqHOTBJgc/hNyjOUbgFypU4xeFCht6zv6H8=
X-Received: by 2002:a05:7301:1501:b0:343:fdea:9a4 with SMTP id
 5a478bee46e88-343fdea2578mr10273152eec.28.1790688142453; Tue, 29 Sep 2026
 06:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net> <20260929-debonair-busy-hamster-be2fda@quoll>
In-Reply-To: <20260929-debonair-busy-hamster-be2fda@quoll>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 29 Sep 2026 15:22:09 +0200
X-Gm-Features: AclHuK_jJoonbrdcWTM4pJ6-SA0D9nOYSb3Qq4ribSs7qfnRaIDq9x1ahszR1jY
Message-ID: <CADo9pHg2JyGyOA=_6orXdhDwj7NaKRBciyQMG2w7fQcPm0MNwg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

https://youtu.be/TPwe53kCJuM

Den tis 29 sep. 2026 kl 10:21 skrev Krzysztof Kozlowski <krzk@kernel.org>:
>
> On Fri, Sep 25, 2026 at 10:22:49AM +0200, Janne Grunau wrote:
> > The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
> > the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
> > compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
> > "apple,t6031-asc-mailbox" to its dt-bindings.
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof
>
>
