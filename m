Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F318E764
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488360; cv=none; b=jcA4+m3W7Qr7UwjhHK8iDMBv6+0H6cmLMB+HOEf88ow9GtXhI8BA6DPAawdMOtZwXM8OmxE2xA3v46N1K7PQsTmDfZa9eekMtu3OXxxSeMY5GSCv98hbxoveGuVWacJiqv8bMHFtGDkvPgVWqx3fjZmaxThokuJ9p74WtemQkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488360; c=relaxed/simple;
	bh=FlJeUeETxp2FXGyr2GWev4hf6sZx/3ANmPmJGGVMNOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nslvCyLWs35z4dRP43V3lAWxDLXS0D+T/btaz/JbMkHNkCFhVQ+79cPas5PJGWPVTT67XY3BjeRdeVME4CJIemRmDg3dR5B5Z5iAx2L6rekhkeCFgZrqK3X1r/8Rvz3SVVF8myd9bFjdVg0BmS4oLDsgei0IcbdRgsuoiFkutvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L9JrbZ9H; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9JrbZ9H"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-268a9645e72so3351103fac.1
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723488358; x=1724093158; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlJeUeETxp2FXGyr2GWev4hf6sZx/3ANmPmJGGVMNOM=;
        b=L9JrbZ9HEhW7idVA2f7WY37zsblsp2PxOlgdUdIByP2sPYo99LQ5UTAT2sYnh43jrf
         O7Cv3iTHixE62+fZB9fxWaN7efQxELf8Y3m4cplkUVjf/1hbK/Xd+iShpBDk2tRQcrT5
         L3Qdq80IEhr5gl53HFyu3KTf2+tI/ENMVqhr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488358; x=1724093158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlJeUeETxp2FXGyr2GWev4hf6sZx/3ANmPmJGGVMNOM=;
        b=RsI7N7ERpvs+LgMEuoPcFZLS+fIYkLKI/PjZdgjy+tpAqXQI/IIP7ebG557B80Vx5p
         yB6ql7mtsBDhszKR/6yaOUpj6Ul0RmDJH7mr7cs5883+RSVNb0RMSs1XSC8wdfOBC9xg
         W1IIxJLYoGUj/ogb8qj+l7682HpYSMib+NRUXO58HZcPNQMH1C5f6nfca52cz6h2tS+R
         uaMh890o8AdRSsSlF7YbwCmWgS6/zIvjN/ed6jDn63nH/hKkIaXUxotrE8G4KRWPkCT1
         Ml/oRYxf0X380vUftvvAJu4TxQxlbRbqAnZvDRIdOtxpKrfdGBxxas7iQzpmuMzrNrxn
         r3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVzU6w1rlTciWHqecCAubOcrMfiKmo/l88xHHvxr4CFeyjojE1UNodfq59HE95hRVznJA/iBhtl3FAbxkp8rLDvCRvKDbQ=
X-Gm-Message-State: AOJu0Yx9TcwZp8pPz43DIoaaffHF0hRNWjSOpLA0eyy7jBwKToXAFkj4
	uAFeaq/3THc+h6mvxck/KfcsA+lW9QcCyx1UBy5LaJo3GrL2MP93RjURqzQTGtgLSw5K3MtqHwk
	EVdfOubdGBMDORDLgei7QAMFKxUmvNECtWx2n
X-Google-Smtp-Source: AGHT+IH30s8urnd9D4vusdb6oKwp0HXj/UnYiPnQHXC9OHfS2VY28kyI7YDJnpNmod6p2kMXZIJDF0yMvKKrEoNk7XY=
X-Received: by 2002:a05:6870:831d:b0:260:eb3a:1bc with SMTP id
 586e51a60fabf-26fcb8cad9emr1220729fac.41.1723488358507; Mon, 12 Aug 2024
 11:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>
In-Reply-To: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 12 Aug 2024 14:45:47 -0400
Message-ID: <CA+Y6NJFx21B9Up14VCW_w_gzv4TGDYL3BsNc_4FOym5GvcY8ew@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev, 
	Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional note - I have access to a variety of computers, with lspci
information accessible via a database.

Testing I've done so far:
- So far, this version of the patch has been tested on computers with
two different discrete Thunderbolt Intel JHL controllers (JHL6540 and
JHL7540).
- I have been using an external Thunderbolt dock with JHL7540 to
verify that external docks are still recognized as untrusted and
removable.
- An earlier iteration of this patch (before I refactored it) was
tested on computers with JHL6250, JHL6340, JHL6540, JHL7540.

Is there any additional testing that would be ideal for this ticket?
Which configurations/types of devices would you want to see tested?

Thank you!
