Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559492;
	b=KVN4S8XQlLMfxiDeZztT2l6ymDuQD9cmbogtNnrU6tJOl+liUav3jzlLm84teIO/uham
	 7CW3XsM9LinGO0UOqbc+XHV445+kzy8ovNjK2OtK96puWloUEXc/zOi2YuK4lZe0W4pY/
	 7dqGwBeWBVjrDd1UV2cd/ll7vq9o7R28PUPTvHknSk/vnR66y8ro5d3gEXr/hi5b/ZqSX
	 TP0Fy+k5dhz8NGjvoTMGyE8p0/faxH7vuNGjVnHm27wEGaurBlFTiaETKjZalzd+Vh9Ll
	 5xGxEX2uOvAYSuIs5/8NYZus/BHxqbPvW4ZfgL3f9RMXDpSqK+UuLe6TdAu3tCnIZlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=x+fjXvjMRilqC/1PD9XiiBtX4xwfGR8XcMAZq+mM81o=;
	b=4124ZDSJM6RwTfM2g7pX2pScebxkmYyweDq2FHfvHHRsMXbe7XwXm8FKevGjJQqWoZds
	 nhGwvmP+ntl7ajSxXD1K5SfqCRrFVmckhHzU3cnvxd/f8elKmGD3OLdN8v+W4HLbmJQFg
	 JhQ2vNOxzFtrlKI5wpF4TSD8YHXX9uepKjfrFPFuQNBiaYDyYxjhbjIiNFiiE9eMf//JQ
	 EAte4OhEBTJkZBEg+oYJlbYwML2jzmW5YN1wprtk51afpcd4ZG38nwRH42WPxPrsJ+HWL
	 sSIzQCcixsIg1SYqn5chX1coOWNY4yFHZ1txc/KfKEywH/RtVjPUP87hvFxz4GxPMQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvJ1xHk9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A460A3806
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 08:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 374A460A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvJ1xHk9
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c14b6ac47eso61887e87.0
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 00:44:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559490; cv=none;
        d=google.com; s=arc-20260327;
        b=USwUZ0wtlpRlzM1u1ZCuqqHOnuqqOGiGZAerd1BLtdR9v6wW+sVtDxBlQ0Fgvc5NuO
         fWk1fMLr2a/yMfl/LWW+JvjVIv3lHTtWbbWUwemA+yxQdddvi7O8sbJCO9L9ELlSqHQF
         uJ+KKHl8bfoef2uznpepCNUpElob5N4in6ZFMrxYyDPWD2l1I/zgY9vcAXjqYA01EfiC
         hOHubhTUIxAa5Tjrzj6+WxWzoPo1yEM9vZLW4c0R7FnSVzwqMyLHTe9dbTDRbRoEp0sd
         oNtllnQMJkULT0AyhAD0G1Hc2qDLQ2OVnkxUj2ODnlCN+TXxSr8h6sC9AP9bbF44T5oZ
         kzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x+fjXvjMRilqC/1PD9XiiBtX4xwfGR8XcMAZq+mM81o=;
        fh=kJXUZ5l1qCDp3UYt3zUzxeHOsqCKvNL4QDDJbJXVW30=;
        b=MrCGowQsFhaw6K0zf4NxyQy95ndBj1P6mrnpoL53e8/hfbJKKZpeiEZP52Y11B0qsK
         s5yhIjwddHWrN3/VSJpwmwHoeXOXm8X62/cR4IyK/79ZIoqMRnsRuOP6nGQsjzexXBf4
         SOQVkgE29KZTOxyRv293mOm9TYOr8hsPsf3Af1k12z/rPh1Rx6W1mgPnDvg/HkRTi2FN
         jBcgFqFZcZHRVElGKzPXfZyczJpVPvhsx56XXk73B/lCSC5AEGkcPN2A5J58rLYx3+KV
         CVl81Qmoh0uBaXsKQb7iFz3jRI7y9FnP86O645GWEti4B0mqUWxx+lu5b8/GsOrop9+P
         pupg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559490; x=1795164290; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+fjXvjMRilqC/1PD9XiiBtX4xwfGR8XcMAZq+mM81o=;
        b=uvJ1xHk9IS0/FgteH7YNpQ/s8m3rgstIx8ZW64yY+Plt8uNAQBb2GfRzvuil535vcz
         Q8Pp5dZYLRLXQQlj1rRTubII6Jp/qV8eq1wqI/jIHx7MVxd5T0HgPvdupdmQHnRG53Ya
         OHKCiapotyuOUL5W1hRmkaPY/RX9ofWoTHNRDBdvipGAqjW9bScFeV2Op4qquB7QmGw6
         9PZ+r+bxeEINsyL0TQCENvlLnBwF4B6+lwG1WEyxx8LYHNhdLZ1nxyzxZOhlZUUycJxM
         RJCRFCLPcgiL+Vwu2SsOFjUEHSkzK8fs8CN9MAZ2s+JsIE2yC/A/HrsgH+bkQQYHNrpq
         Ci6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559490; x=1795164290;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x+fjXvjMRilqC/1PD9XiiBtX4xwfGR8XcMAZq+mM81o=;
        b=q7WOgO+J617R/EViFmeu6RhckbMYeiWQ5NOExP4fbXkwcEf9Nm6gMWC8w33ajr8yhn
         abYZVxoaF+PA0CenAfp++rFOjBem9J/LboenpWPxhMmpRTxABRuPRK9XbeDxxqFeFdec
         rtDFOS4TCPKLaCLzrQj46sNYonV4twi7se5cgwMmSO9H3oxnQE7lL8AOcmQySYG8CjQP
         9w3ztZF4yT3PVZaoB4xF6JNhAgPCfS8QHfiyqlk75TZFnzd/PpCRLy4R6TEBfnH+OpRd
         ppir8X2MWq8yhbPqRaxQRdO0iexeSIg7hoMLI9700WpPO5J+FY3rf9FOOO+cCf1TxquR
         SxWw==
X-Forwarded-Encrypted: i=1; AL+hErGuzOM9+W8tn2bZ4NVy1l2pPRaSFPzCkI4024sOo/7+VJQ9/ETYQux/7bcmzruPO5Sc79KP5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9A5bbGVFDWt6G3eYYY9oBCAdG8bZf2DiTNe48uJNqixQTjFzPM
	Br5shxysRbzSpY01FhzGQCJhoaID3CtJVu4ztnT93rxwa6IIzpnZYaIaUlzZb7pR3ChtTcP7NUw
	ThgF0eFs8c2wYneGAEytKZc8kQK840HU=
X-Gm-Gg: AYBFou0l6/p2NfE30L0Bn0V0J8uhLDletynHWx1oBa78bujMNKF1od3ugRXU5ZBamxt
	o9inlgl/IOfGrJu0zbJp+BO/CO5odPxjeG9+guLjRd97NhdL4w2Gz8cPFruoTioDclKyN6QsZzs
	cZ6vzxY8sBOCmPcN+afcJ/7q22WbNB+RzufTaCDxVIe6H6b2qYk1/rXBLUa1W37Fuzh30SsJZsk
	wL+MgwnB3xFT4W5OcIw98PqjIhJIpTOeDL24m8AF1XERLDomiy21c9Hw5AxrDPB7zJCeD/k4xxn
	c0jlE17SRRCxgp4HcZKoPME6B01anFGa7bCO7W+FMQWchLbKTvlo2TTds9fppgWxTGEr3JX4CLB
	vlSr5oSBZwbdzVscRTaC+32VR8Z5YSesSmG7cMfpdnNqxVxrbT20CP9OwlXoVuQz7Piyx0Ch3PY
	4MQhoEiXDNGc8pkmbn
X-Received: by 2002:a05:6512:3e0d:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c17058b108mr873253e87.0.1794559490194; Fri, 13 Nov 2026
 00:44:50 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <10924894.NyiUUSuA9g@diego> <ea8fa04c-4a8c-4c55-b4fa-f37d74267e93@rock-chips.com>
 <9_7qTfdNSViwtNUGq9D13w@sntech.de> <avU2I_QzCiBPVTDC@venus>
In-Reply-To: <avU2I_QzCiBPVTDC@venus>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 00:44:38 -0800
X-Gm-Features: AclHuK8fX0XCl2Od3Qw3inFMre3WawrBORUXKfjsC28PcE94ozVVaEPRCoHPifo
Message-ID: <CAEy9hNX8fmEZsy-RfTDQz8Th-H8Z+o5tQN4WseiK_+RpZkbTNg@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Simon Xue <xxm@rock-chips.com>, 
	"finley.xiao" <finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

> And yes, I think the other smmu should also use the same handling.

I'll send a series that enables mmu600_php with its clock; it is tested
on an Orange Pi 5.

> @Arun care to also add a runtime-pm patch? :-)

As Sebastian wrote, Pranjal's v11 adds it. I've tested its system sleep
ops on mmu600_php (not runtime PM) and sent a Tested-by there.

Arun
