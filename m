Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C214B949;
	Thu, 29 Aug 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912494; cv=none; b=DrOzx71u8S059cx+V+RNcGo/2sePiXKWW8aA084KvS/uK9dVDhhhIpMYWmaifnEIPQiFpwSBytPPNZuM6IY0tqPXi3T+HQk5faxpPXHGzi3jD/v/PtsvR0+LYBAvdT+DRjDWeU3xUlFb7Kcn+/YHsyh+MzfLWIV9xt7k3v3hi4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912494; c=relaxed/simple;
	bh=4m+yGSdBhixhxvtmH1e1egnd1m06G0SnfHvjAyZhdsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWjFassIY4ueL1vkjEf/oR/XHFNnMc4iSOc+d4ouLfxFNTEjLYBVYjH5189FmuvEoLk+7T+eVRq43a9t1KWl4hZfaozeBJbdzX6omLntwIotBpbcPonmXtFpkcdBn4U8Rt9zGZlVnkh8x+y1vcgOkZ5wG4GKCMhxgjOUDCa0uaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiVOVFUr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiVOVFUr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c32daf0797so3029267b3.0;
        Wed, 28 Aug 2024 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912492; x=1725517292; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4m+yGSdBhixhxvtmH1e1egnd1m06G0SnfHvjAyZhdsc=;
        b=RiVOVFUrXPJiIrJLz0/SM+HkMMQ/wK2cI4xRiT+R6GPTSP1WRljVLjp5zq/gXzGlQL
         9RtkdFhg560BC+jEQbADLPwae4i86uYa1BnivzU0EHpd3DVAwVKJxgt0vCAd9Nudp3dC
         IpfUS6qPrRXwD7EK8OZtJ+pkeLrqI+axobU1ck56CgNFHHDue/IkSKsrKaYq1566tFY/
         R+GRHNUAE/XRlV1nLBUtDd3RZZcjoscwXSzrkCy7XHFxbqrHrJtbsaR9O7u5IR4XpZtA
         ViAnOCp65gJqMKhH7/idn4kqRlKhA45TErgztn/9NiXpZaQLcoqpFmEclqrERsj6qZ/E
         YxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912492; x=1725517292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m+yGSdBhixhxvtmH1e1egnd1m06G0SnfHvjAyZhdsc=;
        b=Vh/BfBMk7GtUToBq3++VeJjeyOow5TORE6v3yFhDerZtA9VogCU74CPO0K3AJUCLr/
         6EwIYSdOXMxo37k+uFP9/p0h6CX8HXvFAbcFz+UjHYHs1EKq51L15xLMaNpjLwN/5UNb
         9Yj29WfqxHfN9y1t6bkfZ35IG5odFH+ulKbtOCaOpRc9ImWk8Q1eu575vjvUAktwZkEi
         wD5XZA/jC+dv0PZnEYBDhzRwHxdeYG9FLFCecXxB3fIvo86JASVKYNzhmMOqoYa/9lyo
         5hzXzgVwP2vmHeznh+BMlXaujKXLWxYQTqxApxiof3IfwMJ8e7k9SndivrRZbiICpYzv
         0krw==
X-Forwarded-Encrypted: i=1; AJvYcCUho34zclj2b8Ybwgz/gENUBB1W4x1f4fLp6LMj1qIgH42kz4vFkDt17PjJTEPau1QMq0mtFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSZygvZeFKsiLLQzCNoScjwxDwpKmAYxb1HT9nWp4i1bKbV2N2
	CTayrFtBevExkWX7ktS5ykrZpcCyegRXxr7Iv0GPY+USrcHST1p8dCjwa9x07/aETTTOTc0xA9R
	Uwg4s8D1ZR3612cbhsFo6ALADm9g=
X-Google-Smtp-Source: AGHT+IHMLEKsLhvNrpFB2co1aHPpoSBzoSmaC8bal4WcNj5PJZQOLOS3kwAZjR3oI8mxlBYACeDUFi9uQ35Ii9qQaX0=
X-Received: by 2002:a05:690c:38b:b0:61b:342e:91ae with SMTP id
 00721157ae682-6d277778e64mr16682037b3.36.1724912492142; Wed, 28 Aug 2024
 23:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info> <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 08:21:20 +0200
Message-ID: <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> Probably f90584f4beb8 ("iommu/vt-d: Add helper to flush caches
> for context change") is more relevant. There was a bug reported
> against it and fixed a few days ago:

I added a comment on bugzilla, too.
While adding additional logs to the bugzilla entry I realized that one
commit has not been tested.

good: 804f98e224e41c16e3b70f97790f84894745a392
untested: 2b989ab9bc89b29dd4b5509408b8fa42337eda56
bad: f90584f4beb84211c4d21b319cc13f391fe9f3c2

I do not understand why git bisect told me there is no remaining commit to test.
