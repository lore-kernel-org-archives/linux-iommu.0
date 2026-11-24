Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795559570;
	b=xoTMa6ocyLKiO4NIV3upAhloYrHNuNos4+NgZ7WBa0b83I/9V3zEbHOKUzKxxC9hybeT
	 DXLZGTfvrfdHLGxpfg9W4GwpQ7TCKeIKAyc45EfrshfWOPuYmHRL4pp/GLsOUxw9DgGgI
	 BmWbzbodLFRNiNsOLqj5OXUi1Q3BVZKb3SheZAo+NsVuWAhWZizV/WpE5/jhzppMPMTaV
	 wblOJm0RykDRaxN4Q8rO1BEoEDzNWcOESr9BoFLvTb8acRkFVuFAWJSNMZDu0ZtPn1K5h
	 +zetWK0lmHjBpafWRRxT067U4u3h6uZ7nD5TSWE/+ujJiorQAuGPyh+R9LqOGbwggCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
	b=iSzFtjaZSM8vNCxc1gNhaYyZkG4JJyborfl+9/EwpXi5I8XoHe0DKyFJ9kAw7jpOzwDb
	 SO9ewi7wwtt0yoveBS5pxs/XkqXlmjWb7Px7Ls2jHoahfo15CP4D2V7vZzREQVTmeR51w
	 eqnABe2OgWxEbuKmdbmhkNrepYgFnYb3eqSCuK/kCP/NNJ01Bm7qLODAqudKZ7osof2yw
	 OH8zsnLEPTiszRST+Fp9HT8syUjlX+5azvWcvqb9m6K15BQL4i3HCMzndnp0dxQXP/yQu
	 NdJJAneOqXdm0B/u+klzanJe1ul4lwJe2gUczEXbgYhn4vmeHtfmqkidcVvF7n1gqTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lWMOABbI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0833606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 22:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0833606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lWMOABbI
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so1080061cf.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 14:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795559569; cv=none;
        d=google.com; s=arc-20260327;
        b=c3QlEw71YQp9YijkLpgIq18gPchln8EmIfkxnPIsFGWeL+Dd1WB556B942sZzv4oml
         n812fzXaI8ZVZaISIx0uJKe066BvUFpKqUCe4w3RFsik/ftTP8pEyU1EW2yimLo5oI1+
         0MVGhJGCVlnkMwKmgDvtnbsZqwl6zroo6yoSddCUjJEP6qo8IcuKftAhsy2g1ZC4mjX7
         NQiuAO0n1cvHZCEzASN/bN0s1h+UG4W/Rys1mCKqK+0cQn8Peopajec+I1bnv2n8OAH8
         od/1uDWiuod9EyhGkV4wLedBKvuHB7LRhpQJfnLxWUr9JKeonbSL+ljPd+xiDXkLEkUP
         RaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
        fh=04BGL4klnP/H3eFUrJbMBq8obpNd7jr8+08Xl4tvt8o=;
        b=sMHY7BjWUFjcjCTARKbKgXjdYJ0js7owINFutmQHFJfC2KRn/8gkTJo+MW+TIV9/F1
         AeiKuXwz97Cqoi0qB3WwXXhsF7LgusYB4RNqvKUkPy5bXLtuWPUYoSJ1GPG8FfrVlxb5
         p2QOzYs5dKo3hChsAw7CpNBZEh/fHHUuL/33CSdqezRaCOohOkJFKLXritMumITc2PRF
         SQP6ANZskGnYgHcHDYiCD3XQxh926yoBHw0ydhl7qRkQkNRYfHjTl5JERBWjbuxfK70d
         e6w+uAXCzEBc7kC8R9iKs+JU+jF5ROd6LZRhiVuxjVVaaU1b6pfhQ/0s2cV1rxYuQ7VK
         EwUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559569; x=1796164369; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
        b=lWMOABbIxwrz3kOEnX6Ua/W0mSPyVuWIp4Xdk3qD/f/e0NYAIu4fKE0oOVysK/3O3E
         5tXDulLWHCEzpt5wzygMa5ItNuLHf9W4Y9YIU/wcpTb1MiAkiInCl9pALuCFrIAJrwwH
         ZjmdM9plu8lfCXBwDocRxgOuHjWpBSAkLh1FfcYhh3TfiC/dlPiLXJuqq9wU4/P0mPfr
         MlNaVhX3K2T8XZLBxTulL6aOtkw/qiYopnxN3nsEC0HUHSMdW0vqVuRqzY6HI7fTzALg
         WGfKsFOQgnmUHO6SJtTw75wcaf/tRhH6ElBSR3lqBj19myGhpIx+pwhTtaiGkRF4Xhrl
         UvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559569; x=1796164369;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
        b=WAWfiRxKyr/GBwm2qVOVy5K3kW+55H0R5PWA7bt8GGuVKYdHlw7lIFziZ6tU8RCpQN
         ZxjcYoqqW1gM1SHXPT+aZC5eAFW5wG5nICh6mzsyt/P4/MbxunGx9IGhPjqYWK0Ks/Dy
         oCdkG9R/B/Ix12JP0ERO6Y/ka7/VQbwViqHgLJQC2JUtoIQ73vT3N6a/RsiNMGTaF92L
         +PJuqn1ujJr8m8vqqi9sr2gH+A5kKJj5OWExV0mIp2AP/xTl9jAO9RAIbpH3DbBb16jf
         BKY/cwZ7F5PObb+WMtNtaVeR2GOvffvo9vEn8cdZaTynNH/lYHntX3AF5pkAINHqJk8X
         n1Xg==
X-Forwarded-Encrypted: i=1; AL+hErF/kndULUbGIVUU9BoX/upsFQcANBPh17NclQE5+xtKGRTFc9GAd3Nm0pwoCC8rxq0Rrze4WA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+uTMDnhd+Gb5Mf1NJnHyORcCh7bhrnHOITNLAJ9E096Cabii6N
	VMWQTHtreuBP0TMH/ZUcwbmIMjEGjGeY7GDhCo7DxWuSRL1xMgKjrA2gNQzNoLg3vWQ301gw+as
	wY7YM+d7oBXJg7zRWAjaXzqUWh/KOagX2iYWfXYLn
X-Gm-Gg: AZFdTZd2650onJDNfqQIEydAH/AXTuwF07447CHMKU5E2IumboiyLCmdYH7hemA5sPb
	qM87/qt5xLsyPDIc99qk54qpo5C4odW4EU+UybguOS7YecUbgJPhY2YoNkoZRNujB5gK7U0pPdR
	T8jkwwyH93/LHOfw56S+TKhbs6gjmiLnhMgDsQl6oQka+7RGbITf2LV6zSFKwW54TCvLjxkuT8k
	Vp120xubbzxjU7UEcVbhvHvTrKOt3EItc2sClTqlfEmsvereWx0v/wx4ai4/wzNT4lgU4Yl3eSc
	OF7/uCwNWuGn9Ysy0Orx3Qqd5gzz+huuJerw3xtzBZIupL0VXSFnQNoZDF8JzYW7gy2e7geeFRE
	t+RGHDstxPj1EDvrjfgbo8JtM0LytFxWiVSCEsKGQ+y7EjJ1tOiQL4NBEavrvmUnTHAcC/OaC+N
	4pjdkXpan4IohdcIQmeT0RlQF+uhbZgTsrX4EeO2D+5decnPXxBiD3LgeIhQcVvWbLsKOTRayXP
	0iNDWNPFXJ0FQdYxQ==
X-Received: by 2002:a05:622a:114c:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-55d88138bddmr71826311cf.4.1795559568208; Tue, 24 Nov 2026
 14:32:48 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org> <awXXSfrhLHK7TNbp@google.com>
In-Reply-To: <awXXSfrhLHK7TNbp@google.com>
From: Esther Shimanovich <eshima@google.com>
Date: Tue, 24 Nov 2026 17:32:36 -0500
X-Gm-Features: Aa3M54pF9USwoeiXdEoOFQBIYzN0mq-CawtxtSt4Q5TgH548xzZqipxFMopdNWE
Message-ID: <CAK5fCsAk8kMCn-VPsLEo=34LvH3=Dar9jG+vXX-0e8mF_Zp5pQ@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Looks like this caused a regression: on non-x86, dev->untrusted is never
> set to true for any device (so we *never* enforce DMA protection from
> externally plugged devices), since set_pcie_untrusted() solely relies on
> arch_pci_dev_is_removable() which is implemented on x86 only (on other
> archs it is a stub returning false), without checking
> parent->external_facing on other archs like it did before this patch.
>
> (I found this by looking at the code, not by testing.)

I agree, this looks like a bug I introduced during one of the rounds
of feedback. Happy to implement a fix, but I no longer have access to
any devices I could validate a fix on, as I have switched teams, and
am no longer on ChromeOS.
