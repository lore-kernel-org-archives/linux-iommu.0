Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BE21B9F0
	for <iommu@lists.linux.dev>; Sun, 27 Jul 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753632767; cv=none; b=cqGEKZCsGEr/Vsn24H1nnlab5P7XXaYePeqQM8djn5lU0bXANKFVECgG0TC4Gj1JYWEXW9gjmwCNKWGMhpwBY+V3VLvezGhcL5Qu9oKhQCQklR2OI1VOQ/OC8HMlee/t+8Lic1XsIGj2FXHB1Usks29mN9AiRpO/E/rpOLtWBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753632767; c=relaxed/simple;
	bh=DFOzUj9K5sz2AyUXU0YQv0swbqE5NNAXVR7EWOuA31c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFA1jAI05k6ADJliUc8n/X6n88KDuac5kX47yMukAWZBdpxG+FkqSOpOqhkqNqh48ZRP0kfgnIHSC1eyGMzqSbAnVsGvPlj2QuRQHTiMsmPhjPJweqHDdaxxPNoqdBgCpod08tpMEZmE4yjP8KkvpLE40fISlTFQfNV0HTER8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldw15QDc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldw15QDc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so7879454a12.0
        for <iommu@lists.linux.dev>; Sun, 27 Jul 2025 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753632764; x=1754237564; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DFOzUj9K5sz2AyUXU0YQv0swbqE5NNAXVR7EWOuA31c=;
        b=ldw15QDckqJNRu0Yv36ZKM891Mku24bI74k9MuYSSLVrqo6VvYy+tbtmw0BMXSN4ei
         63t3QfD4qptRi2j7YmFNF/iwcOOeVEoEnExiOc9Vo53QTNT02AERi3xrF8IOWnQQf9uj
         xXC9uAvCDcAlRtC6X47+HAEXzOEe6DyfGg/0ik2ao9Q3tABevKywde1UyJ517fTJm1J9
         2aQmBNqIAlgbxx6jvHav3cvLEm8v3fTmU90bNDluKiYB38/aU6MnNxQbuOpTXmKapigo
         tTdr8HVloETDMv7dVU/3DPiQDr9P271MLYPkQYQPZW6+P8LerVCu8IxsfnsszQaVNMMI
         OxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753632764; x=1754237564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFOzUj9K5sz2AyUXU0YQv0swbqE5NNAXVR7EWOuA31c=;
        b=VF2IRkRSQnThUn3o3qnivq3rK9i4QTaxhY9JuOlQ5CBPQOF1vpgtWDvhDaGDF54hXC
         ujGyfAJaV5m++hSibVtQ2GvvnRmzR0iQMYYy2Djo97egTL03PhIkXq5QTFHURdiUbW1s
         H9G2yPvMG+rbBS9qD95O0FlnyXDoNaF7i2mjO1J0IOEVk0DfjCs0pUAJlKZy+XDXoLjj
         wna7lfwT/HNOZmOcQ2/xYImT2CwjJVMA1Q7Ui4Dm6P07dfti3S2oygJfDQ9564CTMiUr
         bITKv7BPYmPdVldfKRjz/p4pVTz3jKot1zLrRxPdjye1DP9PjfD+V99iUmjy3StcA8s6
         sn5A==
X-Forwarded-Encrypted: i=1; AJvYcCX0Y03cSthtkntVbiqD22kmX7NApF5oV0WHZ9Tfhk9hXYsF9TpWl0uDZqys+YFgPTl1e/94fA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJrF1ugqF6JyHJbQQinyGmMSSzHyHIcu5PVfLDe8R5sLoH5tA/
	NHWhFZcvY02xh/R9M1DIZVfyyUyTUzOf3yze9D8PYPT1uTnqdXkltLbm+zO4BU3/YEqmQYzKxFS
	Hd031JkjCI8AMWpbSvGHUVEmpgHjot6U=
X-Gm-Gg: ASbGncvnWwREl5ENedPIe+EL+nF68feDI0GvUYj5FhUn7jHkkFRknnw7RngYWeAFU+P
	1u07DxfcKzhcxQJPNDAlhlJkUAIA9A88H5fEF4NvUFltUCDlWP7H2m8dh7fWnLNNMqpNAw9SPSx
	bgrR8zSQkcShM9tt6jqXEzCv0KPofkBNgy/3Nxn8BKeLHsjCbf4Wdti6j/So9fhd7xyBMSm/VLO
	x7jAQ==
X-Google-Smtp-Source: AGHT+IGm5oJzXS1VTNxMFbpMraezq4mknIPV6KXIGvaUrUwahRYJxZJl9clULU2n4xwGWn/Ra+UYw+5hvCzryqbbQYc=
X-Received: by 2002:a17:907:9623:b0:ae3:c777:6e5e with SMTP id
 a640c23a62f3a-af61df52d26mr1030351566b.19.1753632764316; Sun, 27 Jul 2025
 09:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com> <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
 <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com> <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
In-Reply-To: <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
From: Matt Mower <mowerm@gmail.com>
Date: Sun, 27 Jul 2025 09:12:32 -0700
X-Gm-Features: Ac12FXwBICgNG1gWDdZiWG0w1xg4GvfxWwSPgdsBoA9_Nhz0K07_JUa8-TYNFHU
Message-ID: <CAPDiVH_-=DzPjyjDo34-0HG20feiGfrM4eOpkPt6bavrw2qWaA@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Baochen - aside from finding a commit where stability disappears (from
my last message, stability is achieved when I cherry pick "wifi:
ath12k: modify ath12k_mac_op_bss_info_changed() for MLO"), is there
any other debugging information I can provide? You mentioned that
firmware is a likely culprit; would it help to get a dump from the
ATH12K_COREDUMP feature (commit "wifi: ath12k: Add firmware coredump
collection support")? If so, could you give me a hint about how to
generate the dump and where to find it?
