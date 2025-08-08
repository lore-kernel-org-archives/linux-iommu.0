Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53318265CDD
	for <iommu@lists.linux.dev>; Fri,  8 Aug 2025 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637743; cv=none; b=ITEeYNXvkfrz+BX/O0srPxv3u8A9CM84uotveF0MUygJd5yxf7nA/YtaDwKT5rRCVpg3qNsRFxeFgPVsQCq48HI7Qyx8v86YMrpS0w9VOS3ElQ+o9B3fAY6K8rotIeryQoHr5odG7oAitG/Drz7FlKvMp8c7pEEzZOjFm61tiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637743; c=relaxed/simple;
	bh=L6qigGD3i3MYLl5oOVYcHhynzYozRlG+YaaQuV2Q5Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfQgQHYlskYTfMBBVDQPms+gX/qOpMRPcotpAqZNuenp51xoCL3wddHPbqYVgBEAylz6txeVEk9LSii9PZHyidbf74e0fX371/dSQfFf9ri/cNuts4OHFpkzIkP48SxP/DjWMjYX3kozqudHOWiCEpyMEDUrtlaHl9wZ31ErsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AicvPNnZ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AicvPNnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754637729; x=1755242529; i=markus.elfring@web.de;
	bh=L6qigGD3i3MYLl5oOVYcHhynzYozRlG+YaaQuV2Q5Ng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AicvPNnZ+bPukWOatsrz2VaQ4IhjMvPXBRlZ5sQCQvNBBagP/WPzhasZ+LlHWIY5
	 X37px3R3bvplRdFDsFu4IwE0zq0S8Qa38DFG348VM+UhcTYYOhej48P/g8iKUJmif
	 hlc/THQu3NRaxVx4TE6e5gFDvIv3z8zG2yZzePHXPOZ2z0LEgQ/6LfwNjYPWZ0IzM
	 KLQzjqH2c2HkZPWr50HrODbwcosG4PGQ1J+JDZaLhmqPbeSKoY+fjqwDRwhu1zTOc
	 UjkMs97VbTXHqY4Km/2jztBLGboNP0vAGbAnkrxcrKbHAr9qGPY6pjD5jRcXTfi3p
	 c510GOM/VASb/7sAqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1u5BJs1jan-00poTa; Fri, 08
 Aug 2025 09:22:09 +0200
Message-ID: <feb46658-5a3a-4403-b407-500566280eb3@web.de>
Date: Fri, 8 Aug 2025 09:21:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v?] iommu/riscv: check pte null pointer before use
To: XianLiang Huang <huangxianliang@lanxincomputing.com>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <effb29be-6d14-47e5-ab71-454119467750@web.de>
 <20250808024203.16672-1-huangxianliang@lanxincomputing.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250808024203.16672-1-huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WzOWk0XQCVAGxupyOTR8XejPCO8hY8cS8Zgl1k+bx5WwaHxY0V9
 OUZ3CSVg/oorEKD9N8iTBo+d85TyR1oZ4rPORcwFASf3VlAyXomFtUo5YlkW8QJAiYNaF+p
 rMJt4Kd4sQqLYWM/pFLNS5Erp0wyT8TWm9+khcQbzaeZMvOVMyV4oLcdv0N3tiQ7zx2heUj
 fR8Eb/m4Szkqslue2N1Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s+ewVB6czIY=;qFCwrnWUaOJPf0LC77IxQyqJ8af
 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
 woLqKuU43H+SbOICAOIg==

> Sure, 'prevent' is much appropriate than 'check' here...

I propose to reconsider also different effects from your wording approaches
according to the summary phrase and more detailed change description.

Regards,
Markus
