Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6163FBEA1
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633718; cv=none; b=X/vhZ2pCrm0C8Rb/W3Foidm2GVkQ4LclMeXRpdxtkjiqAwjf31UCHsLmpEItGAVeQwTzWN/qN4la43q+Oimoz/ltbxWEUljSMlCbn/hTaDUgbQnSfqMBokfKcqfijaBGKWn8sd8kyUsRXjDLbEIOaKMhNAXOkAsN9doh9UBMmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633718; c=relaxed/simple;
	bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=uZu+HQ6UGGIuBtDqQ8dEVKnXdHgb/kNXT/DqKJ+Jeo/9aKWnzOcRgTibg6GHFAX1ZNLSBxCegBxkIWPlAvB+rPNroThpVfBQ4ldI9D3UYiuQMmzU/NVXCnwibJaee0egi7RRCVyWakB9pPTwyMxnQRd0S19urwyYAGsMxli1bRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM3uN3mV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM3uN3mV"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so3026586e87.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633715; x=1775238515; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
        b=MM3uN3mVn60AUInB/H2l4USA1LnxxUrlNTHRGzLh/7NH5DO7uJRfPGEBGckBgebSBK
         5Ux1AG7p/GxEbRkMiCtKMYgmmEWKkfOfE02Cc40u+Fi/V5nRt+W/OYwViggfnonppmii
         Qbtkfh1Wi5lzhq+JBY91CyOMauKzllNPaFbmyldNXVdv/NFu3rBy3udAUqXqp6NnrH5l
         z6mrZ14YTUgaEJ6GNAda8whJya7V1f++yrqwBXxFe3HzV5hWwikZShiB+VBAeSLAkx0e
         PE89f379OxEJsRtpukKhlcdFJF8PtTtI4VIdBvUVLAzphoAKK7arrmGbgfvgPZWehe8S
         b+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633715; x=1775238515;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
        b=HhjMmsQ4akSxWxf09aKndvm+QJqwmkWHbDOGxzSCWyrRiZjGbTB8ZJNrl5x6wtDcPC
         p36e9EY6VHth4oVStu2PB2W68Onl4DcV25SOCxY7ytNW7fg6NvnCeGYXp+Yy/PooA846
         ARcQN336BfCDmT7bBVletgQs0c31R0M1Dx1pJ1aHYvEJNFc+prV8tkyXjzSG7BX5iswN
         siV7O8xNAUKRky9WOuTwC9SAp6W4J+j3BP0PuuF745cvx0SCZkjW5qjFqeig+qRuST6t
         P4G69nvpj5m3ZFjk1IkYwMTZIsiWltpjGPaRLxe5+kt+xvfxFdYUDcrcVwvsW1/wY94e
         a6sw==
X-Forwarded-Encrypted: i=1; AJvYcCUadOLKC9KoGgL+N1a1giyxCwHUfOoWKWeKyy7of0wbFFCNkWgxl8K3S+/ID9OFMH4kkldH3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9z6vKPG4nqw7GH/K2GRUEH0Vuw6XDvJyj8S2cJVIpiu2lK7ou
	VZv7ZMMuavO7XxHc9EOy9W5J28i/LyHURncNWYaHh0kRtH5LtOOua18=
X-Gm-Gg: ATEYQzxhGQp00i7qgwuC934sePDXqVhu/IaRXr/iNQjBm7LPEqcdklUCGDKQcssAK0C
	/LALdrG8oOcDzABahpQsVQD5TiInsK5fxU1Dr0uNSHsadMz9KtNkx6OGQVODuAA5Jnv5eJ2tVOe
	Epk88TnuVTD0PUceYb/lH7Wcqgv+kltbb7bDbvZ6pRHZOCZS30HwBd/+H67ffvWbWNoimJPJB5Z
	IAT8eLn/JlXk8Zc7CbJ907NEft3OvZv/7sEEjJwh8fqaSMECepLhNnZlf90Nyqf/BrxhO8yzfMv
	jljAOZ/xmrSZofrLogBv+QDGwVRHiHfEY3ZdVB9d6H/CcxYIS/GnbIHNrEFaJfe6iq+mm/UsBqq
	oGPtjsEWhCC/a/7geIClZUX80GdSt3yuNKJe9zM8mA5fWrZvsqwQBP3vwC+y+hk4v2WGeh7M2dL
	qO04I68o4k3BZFSDFSooog3dFuMFETmQyAiwbEDfWmikjTl6Ilyxlq/xbys9eG6FZSQF2Oyd2Hs
	B2s+B1htaiKrj07JRv28/ZEtKd3r12uXfdoU4QY8gak
X-Received: by 2002:a05:6512:1088:b0:5a2:a13e:9095 with SMTP id 2adb3069b0e04-5a2ab5ff25emr1603294e87.9.1774633714730;
        Fri, 27 Mar 2026 10:48:34 -0700 (PDT)
Received: from bf-laptop.int.bjornfor.name ([84.215.3.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a0645116sm1498878e87.21.2026.03.27.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:48:33 -0700 (PDT)
Message-ID: <c4c952a0adbb28e572f2a05fcb317f905fe3f607.camel@gmail.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU
 for OF platforms"
From: bjorn.forsman@gmail.com
To: mani@kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux.dev, john@kernel.doghat.io, 
	joro@8bytes.org, linux-pci@vger.kernel.org, 
	manivannan.sadhasivam@oss.qualcomm.com, robin.murphy@arm.com, 
	stable@vger.kernel.org, sashal@kernel.org
Date: Fri, 27 Mar 2026 18:48:32 +0100
In-Reply-To: <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mani,

[CC Sasha Levin as git committer of all the cherry-picks to the LTS
kernels.]

What's the status of the reverts/fixes?

I tested even older LTS kernels (5.15.x and 5.10.x) and they're
affected too. IOW, the only LTS kernel that isn't affected is 6.18.x.

I hope this can be fixed soon.

Best regards,
Bj=C3=B8rn Forsman
