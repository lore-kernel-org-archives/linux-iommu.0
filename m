Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521348;
	b=LpB8DiABUTOZXdX459Pvs14bhZQMfRRvcTMvJkNSqB+djM40VR/q8hGEu7BN0xridbLB
	 DLTT59FMsscSACGmOpt+1XFHi1SBVQBdqexdbiEpEienK5WBFM5ld/KMQO/+1xgaqGhVQ
	 ruoCqwLQnSWJ4gL88BLsDQI+uS40XM7Ti0zjzUYSqHwYVYwZPf3glM6yvtlU4tqjV9sIR
	 8GqR4bUxwnVysZwiYDiPVoB7XPiAYgUgo/u+MBE3XPhB1iUVBy6YmwZJ4uNPyMCHQSG+b
	 xdmTgmt13HvcGRT+Nx20NzdoFG1Iz8lUT1uBho6M9PdqwbqrBwt7DrB17wMu4jQhH7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vnwt3Hg75Jqhq/RX3EnfxRob7Sm62Nv/9HL8t2YUaCw=;
	b=da6Ystl0P7H1AyMaoDOy3tbXKhWd+NmgchEgFhF3h6e10h8zrXvhg1ExozKLy/9hmgBY
	 ycoo+iOLUoj9CRBn6OCh2e81+Di4PsOAsPTfRSnZmV519h8xzEzTgNmbqW5Q2i2OMBlZ+
	 ZZmKxB8aSmfVWMxBaQePZ3WpU1/eWTM3rBmCGYXsvi6Pj9dW4OEh8CI6e49kcq0rOBfwG
	 YukVashth31Ss/rZR9w+Xy68w6OmvCP4py4E0M/kzOdBVqt33J/Nk2aH76K3tY7IfEjdo
	 HbkzgXF2ZpvSA+lcDTnrAVAyg2LjQA/huoy4icyZWTPnf1UB+WTH85WQZqcOyCR1nWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hidw2Lcb;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0924606A32C
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 11:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0924606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hidw2Lcb
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3939956f8f.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 03:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795521346; x=1796126146; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnwt3Hg75Jqhq/RX3EnfxRob7Sm62Nv/9HL8t2YUaCw=;
        b=hidw2LcbjBOHt0L7xR00edM+4w8IkrZGjI7cUkRHQNiMhLifjMH7Qxgngd0mWfLsNV
         m506CtLlf9tTwv+jCj4h67YU0nqEyjFRJCG+kuWfet8wdcNltA3bVHwDz6dY5nFjN8fd
         wdc/OfEZzhF1PMLohg6bW+FlvSnjWHFgnsDksuwEsihyBFyORmFeJYJaFs3ypSiZ8+fg
         dzjsALybARvrhPMvZDuXfDMuYRE02ViLNiZQbCOJvjncGVTR4aqfohhZ6KdEvCdfUDOj
         AYtWKmSzO/yQN0uReFgQ4M3Y0Y2W2swxQQ3LKIJdAQkco1Nn5ywG73Uq6lxn2Knpa8eS
         CBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521346; x=1796126146;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnwt3Hg75Jqhq/RX3EnfxRob7Sm62Nv/9HL8t2YUaCw=;
        b=Ju2WlKrORkajK8DHZDM9OAySWP9lLfodpspjVb5AGiuevDvPiIE6F6uykP4gGlLZAm
         uhfnDNaQkQygkczrvd+mCjniSzhFVp8q6W2yYpfpteuBGoRbRcgMEaYbRMzbPjzgRDRr
         3tDvcZwdFlDlJgdL8iYjARTdAN1PskFygAuIGn2yBvtFXiloepmvCOe5kuDIcbTfrEns
         4Ou6ej5SV1z2wUPME0vFRfy6Pj8XAj46JEQexi+J+l1sJ16Rr5Qwl2t7k3v1CKwvhonI
         UelAQQzvHalT8/swjuBCCk9n8Jegyv66JUBDrlC3Eh5XMEL1Px9wIF60CY0hFnKNgCWH
         DGOg==
X-Forwarded-Encrypted: i=1; AL+hErF6C7+7a/ixBoigtx1letxduEoDQE0a0Jx3xjB7QDLGlDr8kiLNU413zelz/V0Po/ryOYcbYQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VCRxt5Apf7mdwrSYqcu9C8ZSIlq0QhCMSwipOjhpQAdg3ojaN
	FjyIPJWm6kwiX+kwkYS0eUE30aNeBTnAEjLWiPr5kRUfI2EudlRiaWoCESMU5R+aTXY=
X-Gm-Gg: AZFdTZfBxF7aHBWPsrcd9VnzLQIfnV+dl2bbxIn9KsEKv0EbdfWnsj9hXPShH6x1c/R
	SoBSBBGYqwC5o1sr5HVBFfzI1wzNQmNODLdCZ7QBQtB3iKFiMEhXL16xLg6mNNbK9QM14pXQfls
	EYfcJcH5gRkS6Nr5SZVwrCU0xvVZYyeqCjMKGEaH+oi6oUsyy5/FTA0GAQoZH08haa4pIFQZ1+L
	Q3kjEf0sI4wUrW99QX0a2v0l50JVVMepWRgYPByKnKUFAxd63pN9G7ttFzScylPF4BFE7D5aeFQ
	SMPPQD2fKahc1CBKoghXvN2/CN3J9KxiarViSIE4G7UuwF7IemZ3ua/xTu0DQZsRbRYXGeo+S02
	/EBwV5LUluxzIBq1F7loUA0JPFygT+elY6DfUUoSKNtCtzEhWmLNw8dtw+S9+0z0DFcBgTXDTla
	kx9aG87pacRas4ZEN8bikF866180gSMi9rpTU0ED/yeuqMyIcbmqolAwp+2Gupe4BMD0iUWbtf1
	6//y0jM7ZVwgxOPzepdEj1t6KPi70a6MzQuY7rEPl8YQXGnInPyxqSJPMmGSR2zopDEW1LI1vVP
	4ZLdIUXUeTXfVWxHv1eUf8h/TG0qD7zJffC6OOJcHEhD2D2hP7LatU+lc82HF4xNKl9InmC7zxk
	tkt7YKK7GkKg+tKFV3bUqKOg=
X-Received: by 2002:a05:6000:428a:b0:4a9:dcdb:2e11 with SMTP id ffacd0b85a97d-4abb8406ea4mr29382891f8f.41.1795521346404;
        Tue, 24 Nov 2026 03:55:46 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm26566053f8f.40.2026.11.24.03.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 03:55:45 -0800 (PST)
Message-ID: <bc4234bb-8901-4d0f-bbf9-66f9715c11a9@baylibre.com>
Date: Tue, 24 Nov 2026 11:55:43 +0000
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
Subject: Re: [PATCH v18 8/8] arm64: dts: rockchip: enable the NPU on
 rk3576-rock-4d
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <0bcd73278a4c7a0cb2e1b8bdb9aba306355384cb.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <0bcd73278a4c7a0cb2e1b8bdb9aba306355384cb.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2026 00:01, Jiaxing Hu wrote:
> The rail is switched with the domain by commit
> b1bff9ced657 ("pmdomain: rockchip: manage the RK3576 NPU domain supply")
> in the pmdomain tree; without it nothing holds the rail and it is turned
> off as unused.

You can omit this part of the commit message. The dependency is stated
in the cover letter, and domain-supply is standard enough that it
doesn't need specific documentation.
> npu-supply is set because the binding requires it; no driver uses it.

So why does the binding even exist? Is it because it will be needed for
implementing voltage scaling in future?

