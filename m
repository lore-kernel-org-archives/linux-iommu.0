Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2673009DA
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765337022; cv=none; b=mjQCWrq5kKwuOQABI1F3Hz6HZWhFEI7M+GHymRIRG+GmyzxbReoksjQilsKgQGLo7POLQnXinUSpCzCf38AMLVeoZkprluJr5t7TCd28sdi4vP3Tv7PgPcx6Mb+YTkXaiJKjDKmPNAVQPowBP0Tec3wYPVHPO7X2ILXBoqPPDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765337022; c=relaxed/simple;
	bh=sp8r4MEnhaHgP/GsV7U/YqZG+WaVztHr56tiyAJ++VE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t6Tj5bFsR5/CNBymSzyLXQMXVwa4KyyWxiNfVoeR5ayGis/FEiRSQXAAKdfPCy/fiVBaNy74wWg+6EAtvTB5egHkd6NDV0Vp8V1AuzLFY846heU1j33z3cO40LBjhxpj7ueEuV0ujNoxf9LPfBjLlJjxedpIAzBfXO18VslbZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jbJ7nHzC; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jbJ7nHzC"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55b1dde0961so4222370e0c.2
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765337018; x=1765941818; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sp8r4MEnhaHgP/GsV7U/YqZG+WaVztHr56tiyAJ++VE=;
        b=jbJ7nHzCKW3rSWABkt9hwWYHw5HQRA5sy0kfafxBy+e1ygKJS61DSpM104nik7ozrn
         YKtaKZ+ZpqIQMhWUYgPR2QbddLLyv6AW6G9w1yOxtNYJzcsag3sMCjO2Qtvym5ZD7Bqr
         1FwoLtRPiCpgOMbIK5mhKbLlsGUpiuDzE39UgMNt+saIGa7dEXwu8+6qqsusbaLv4Skx
         hX1UEYwOqUHtHVF89TgTPUwuaWvq6QI71BQAv43sbjRtwgQZKqiG5GsGP9ilI/KM4xUj
         vPgkF2rmXio3hW4l/8eTkynQYl7dBD7mEFNLBIL8nHXrMiqnoeRgslmrCFToZt9ZjJW4
         URcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765337018; x=1765941818;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sp8r4MEnhaHgP/GsV7U/YqZG+WaVztHr56tiyAJ++VE=;
        b=pN/oQg7s3uqzReCmGbdhQIzicyydeaJAsY+x3TPdxvb+yqc3cUkWfXoV7TKejpveea
         ZVtbR3R9l61Wij5kpzuXIEeaxwdnjAZIwXnqwbKTfDLhU5uHF1GRKEs4nLuficcrPf3D
         dOnndJvU0qgQeREOD03toha/un2kivTdT6/W15O/+TTg/JuZ6o0MS1wfNwEwM2kMPW1m
         Dg1c4M5Mq7UPKk6jbTIbWcYXG5Sm2w3wn3b9WfHhIWrjsZkK7WAJbFucQL1xO8yRHXq9
         /OyPvYXWbYdH73N0Z4hVPANn8DofdmrOIFXdXSeTuEWkAM5jGxMXteEEbeT7/3j7k6Rj
         X/vw==
X-Gm-Message-State: AOJu0Yw5gE/pRrJDNeCV0UOYJHaGOvA/nowmv6XhwmbgiAKrveB8MvnI
	34+iZmzc1CJ4gx3stIOlSD5gbzfMkXsQtni80c5/UZmDzIiM/V3oJ/bmdKePWZhm14/DVk2wxWk
	oaYQVIBn7KakOMw3TrAPfwg4VeYpKKViMO5OjAdaVhg==
X-Gm-Gg: AY/fxX57cEa4WtNbvAkpH+Rr0DwEHxkJE+vZD1PM4FyOsn1O5M7lsVLodom8Q9yjY4I
	t9artf3F8UdCBF+wZgFpOYR6Ai2IPhmHosdjz6dqqWi4owwz7qgpLz65NrZGyTOj3sbNoTZvYvt
	6UO9KpEfffVtjZnMfnFTOvL2R1NoRsTRISarsNt5+UIVAXnlEDy56H1mXBaLAqQKnVdtnfScYXx
	h6wzh9BpHjDmSA9uxjCp/zq+sv5bT5Amtl8w5orTV51+hFH0hd1MH22EdxYWH/LqHh2u4WHw1N2
	8vz3XZj7Y7rwsobVN5s=
X-Google-Smtp-Source: AGHT+IEmwhMW1FyeZshD1+7NR1/UZ4ALcKJ/slV6o0DtRyQArUoOlhK6Q4gkpo2enLrP7djyqpqTN9L3jOabLqwpyvs=
X-Received: by 2002:a05:6102:3313:b0:5db:d6dd:81c6 with SMTP id
 ada2fe7eead31-5e571b9ce14mr366028137.18.1765337018014; Tue, 09 Dec 2025
 19:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 10 Dec 2025 11:23:27 +0800
X-Gm-Features: AQt7F2rejZozDc7tP8Z64uVCLp-9o0MUbwI8t4sHQoeCuyUIEEDs0pcvXIaKbH0
Message-ID: <CAPYmKFt8bu48mi0awW7XWCiQvQqKf0VzcJbx5VR0VmcT0zYZ4Q@mail.gmail.com>
Subject: About RISC-V IOMMU PMU
To: guoyaxing@bosc.ac.cn, Zong Li <zong.li@sifive.com>
Cc: iommu@lists.linux.dev, Tomasz Jeznach <tjeznach@rivosinc.com>, joro@8bytes.org, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, anxu@bosc.ac.cn, 
	wangran@bosc.ac.cn
Content-Type: text/plain; charset="UTF-8"

Hi Yaxing and Zong Li,

I noticed that Yaxing has sent a patch series about RISC-V IOMMU
PMU[1]. The same driver has an earlier patch series[2] from Zong Li. I
am wondering if Zong Li still plans to update his patch?

[1] https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
[2] https://lore.kernel.org/all/20250115030306.29735-2-zong.li@sifive.com/

Best regards,
Xu Lu
