Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7398003D
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269094; cv=none; b=uphrUJjLfMEQTo9ppRB1XAKkmlNBfeZpNkbHwkI3pz76XH4HpqDJjQf9HBEFOC+TQ7EtLbAWmOzq7oHKv5vmhW1bEh6m1xDGeiLB06noUA5v4I2kh4UAWEjzUF6XgIphtmAVZ6Rp+zRrLfapmoUtxVryYBwRFnnfaubivJl0hJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269094; c=relaxed/simple;
	bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=CkGbsyWEu7/MLe3UBnIVNpo5d25m4dvOnYIIGvSTWow1gHFYhpLqIZfMcq607DvnuYDkJEkwff8Ucd9sN40nY17R9ZG+hUfDZBcGr92R0MsmDEIiUWJnwAZzomfhQHVMY7KXB7c1egn2LP+MfwJtuvdJlKg+4byMFd0qImgMYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGwA+coe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGwA+coe"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a27a90a7b6so65740e87.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269088; x=1774873888; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
        b=nGwA+coeKg5g3ICeJmQvHpKNTbE2Vk0jneP+FUvrK739oqivmS0lwjtOIVTP7bWMnw
         AoaAkTZaRKEggKDAz0hwN8eW75cb0qZFYMRpNS/q+OwQxIWiaAW9msnjLfqPb4JukvS5
         COoMO4xNwVoNbxhhDYJGjVmScw/A3dBvr22daZZuL7sgoYlLnbgxGTWdzxDGZ/F1h7w4
         6DRBeMs43jUK/XqtKrv0lkvJfhg6vhel1KlR8lQwn5tCzr6Gi8jSvrMeqXQAYmwROEpd
         iTxGIUxiHpxTkn/BQ1DvOFMX+aMgDOW6OuS0KWZkLu9CejTHqguB6zi0AmeExthvcPAf
         0POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269088; x=1774873888;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
        b=BbJLKOhOJKjXje23dt8KpHFeOnu0X+y5MDU0HwQNxZqgm9oeFiqZNllTd5Aeykbnf3
         KTiSQ5qu3pW10p292tWj6DEDGDBxOPKKQRw+yLY/klllIcdyyydtpCPgNVUuK/q4tqy1
         0+qlDdVCcRzy0Goa4lLtj1ufRHPnWnY5x/xRWm20K7H08pL47ni2OzWIGjTAyVA6GBqi
         zxKnAN7UkZAan1bnRdscA+4vrkoYykvg5JsGFCJGZwZneY8jVwRNjJxISowagH8bHdVY
         GtgWGSu6masc8kMkK0dZUkaYsJ8EDLC6Evp6Mj73LQq5Vjr1DRYCOmFW+7COGX3n0s8b
         pkQA==
X-Forwarded-Encrypted: i=1; AJvYcCVzNiXDz+kNdUT4wfnaNYc+gd8jJI4WY3mkE4SnebcrcXd5SCZxlwTErffesA6fdSS0u72g2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOuKTz8R4Fcx5qjkhHQOXdGQH8ZTG3j2scHL5d1/o4Cfaqqqi+
	NatYPf+xW3T8w5CRH45OOleKd1m3Dd5OxCI/F4VzdKR9mNBVWkhu8Rs=
X-Gm-Gg: ATEYQzzQKv/l76vXEAOHnhF5WBhkKfsgxkvSxfq+dt8rlK2QFHkp1+WWgl1BIDD7L0l
	JYvSPhw/CLjWk0wWR0s9Geo6dxHJAcVUaRXIy1pwei053PiM47H9Wi0bHGVa4dq8JK+GCol2jTV
	hy70Zz4vliaPDK9vpc9x72mC9CxOP3YlvqTwql2Qr5Oot5OQmeIHHXg8s4kpHywxDfIoa8tzT86
	3MqS88qZVYGjBqfjMJsxH0KT8VOr0hsaSmDUhT+bOGTi0jDgOwSMXP4qVbGf339iwvMfbKKGi30
	ysaVE9ZzJLA1O+M0QLbI6D7/g/vy9Wr/BdqdGmxk8M95bNzraeP4yO4rkwtjUSwSwDr21BTlat4
	nljHd7TlubTxZ4DUN2o7udeVTG+qVwiKqAMoO8ZYBhDcFO77WY56Q5sfOIp+A631WsceEt+pvF5
	Py0WApKMk2cp75URP1hfM+XU+vsLb8kgSnaPXgkNLiPWkrS8lpxJNcmSFGH/WKcUSkx83L/EwNl
	gIgbN3fabxhQd9Y1EJwwZW8nTrOkoBla3cDwmth4IL0
X-Received: by 2002:a05:6512:acf:b0:5a2:799b:4055 with SMTP id 2adb3069b0e04-5a285b92854mr3712410e87.39.1774269088110;
        Mon, 23 Mar 2026 05:31:28 -0700 (PDT)
Received: from bf-laptop.int.bjornfor.name ([84.215.3.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530cb91sm2582086e87.77.2026.03.23.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:31:27 -0700 (PDT)
Message-ID: <457c6760c569134a637d43d38e86d405963487d9.camel@gmail.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU
 for OF platforms"
From: bjorn.forsman@gmail.com
To: john@kernel.doghat.io
Cc: bhelgaas@google.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-pci@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com, 
	stable@vger.kernel.org
Date: Mon, 23 Mar 2026 13:31:25 +0100
In-Reply-To: <20260320172335.29778-1-john@kernel.doghat.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

Thanks for submitting this fix/revert -- I spent a lot of time today
figuring out why my VM didn't start anymore, and finally came here.

Seeing that it's been a few days since this was posted, I figured I'd
add this message as a "ping" to the committers, in hopes of getting
this merged soon. (This regression is hitting end users now.)

Best regards,
Bj=C3=B8rn Forsman
