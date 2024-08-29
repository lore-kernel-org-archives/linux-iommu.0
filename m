Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163781714CB;
	Thu, 29 Aug 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916223; cv=none; b=s5N/mG0QC4C9/iLDbbPPoU/jfjD4XXCpefFMyy5Y+rYy7Bl+aGJFR5iDWEkhfwxLTsxPoNTe6iai/oT5hCaO4HQuKlRhPRMUJrx092WSo1sJJ57QTrWLRFlpVbIeWqNvgQPoZzyosvCgBAdlmN7v+Vw3TPFM9zv/NdHlnC+dfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916223; c=relaxed/simple;
	bh=YnxVcqEwHczoY5YsUvZMMyJkO1hH0Qn/C1cCB7ULFZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmDbqZ3QMQMvfDBiTRG7uw4LIzxYg2izWc3i5zosftC+etJu8RK51hpmHmcAx+TiVoJ4IyapH+b2JbZgNolfZ3R4S5hox08l8ZZx/SkLZhuwNfb5WAZbVJwup7IgPQfsE2RPr9PXWZmYKVc0wmulVzAcuM0cTypEELELv1h4PVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDRZXQuM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDRZXQuM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b47ff8a59aso3148597b3.2;
        Thu, 29 Aug 2024 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724916221; x=1725521021; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YnxVcqEwHczoY5YsUvZMMyJkO1hH0Qn/C1cCB7ULFZ8=;
        b=QDRZXQuMDmLZOZgGKg9IOYc/Jfrlr3U5sjrdyMgmffdo5CSMOT77Y8lxmWYid0eHVu
         iBtQU5US0GTF12YCGMMgO/53g7IotYM0JBydppkOFlN7NYeQAq4OuKkYu0kf9dak0rml
         g/Y40wWaKryIh/ph5hIqnFgw2NYsLunLnLSc9ZPCysS3zZSwg2BBbaPoZZi3DxuKkB09
         VbDJC+yRxlxfbNpJbGw1SL7tqmZwliaAHNJ1BMmeki5Zy3tmxFRwKJfrUuasJJBIpwAN
         LuVtW7MdhWwRdiyKH41k2WOTGest1Y8q0P+O6LEI7nrmvVTXp8qJMu7ZdOsKhshcq/kR
         tPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724916221; x=1725521021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnxVcqEwHczoY5YsUvZMMyJkO1hH0Qn/C1cCB7ULFZ8=;
        b=YBkVtQhMUK68hjf8VvaAfDjCGPJ5Q2UL6hgSJhVTVAHmyeYyEXJM2Mpyo69WUT9mt4
         TYFDYN4igZv+OIZxIvbGjtVo4cndClDXmBIS7fl9/K732Hpz9QCNwh3LmIywhwbmrmjH
         fZy6DU4ahXTtJjNSXsQGHik9cfh1Ns20WB/YcDE5e5h4zYP5WD/SCRZjeJzc9h1p4cBR
         LhuGBOtclNIaNDbNSh9dlKVvEC+NnNospYW4q+yAKGOEcurIPrF47pgEzpvri30ffAMk
         C8ledU+gpVj7vrR8nl+wJLdvOUmxYWPOaUkAWL5PzK0E/OwW2CC9R+XaIQEy1xbGsfsk
         0Q2g==
X-Forwarded-Encrypted: i=1; AJvYcCWg94X0eQF5obY9b4HsnqSblfFc7d4BVcplo928AvZGeOX5qku0Q649JU7TBKQ2Qc4/9OmavQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/zyTA8GRZmhTatb2uuTxoJaeuidal6VP2Aqwa8ceyb3x0C1IR
	25zAtk2vivxRfP7cqAgqqMg4dRylsNVQQGEoJhytZzrewapKpF25snP+2yMDeJ/CO4BXQgKEN4I
	wV90zSDUQftx1vmnVZtltwrt8+ow=
X-Google-Smtp-Source: AGHT+IFNi7ECsQbvmIp/8PfQr/l55yP9JwlrflyjvYOYxQFMc+pqAgeOq024GeKshYzuoSfkpgWZTNj25IgSp1Z5FWs=
X-Received: by 2002:a05:690c:dd2:b0:64b:69f0:f8f2 with SMTP id
 00721157ae682-6d27595e9b7mr20236247b3.3.1724916220881; Thu, 29 Aug 2024
 00:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com> <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
In-Reply-To: <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 09:23:30 +0200
Message-ID: <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

While reading the diff of f90584f4beb84211c4d21b319cc13f391fe9f3c2 I
wonder if the following change is correct.

It is about iommu.c and the change to domain_context_clear_one function.

Previously you first store the domain_id to did_old and then you call
context_clear_entry.
After that you use iommu->flush.flush_context and provide the did_old,
so the value before clearing the entry.

Now, you call context_clear_entry and after that you call
intel_context_flush_present that contains the remaining part.
In intel_context_flush_present the domain_id will betaken (AFTER it
has been cleared) and call flush_context with it.

Is this done by intention or changed behaviour?
