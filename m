Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A6126C18
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762906; cv=none; b=TOm8y4HbDTFCc2dmIdQ6o12O2vaO3YMBvQ3bMnQNg8l9w8U3xKXC7O2B8HcPH/Rmf5GlFToWHcuEkmUHrn4SErjiHUqBcnIbhXrtXugPkZxaUtne5yWRius2PAPwmld6sTMuBuHMCiw+WcRLRNwonRXQfhn+lDRiqzSz7QOagLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762906; c=relaxed/simple;
	bh=Lr+5KZ13veBJ07It3Yd9s4/CTrSJcCuhjjvOpdqKT/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDtlhjzf43JDpt4BCBeMV4tpJe7hT881llzSPxqPyxqTRT0aCex5jLOcHb+Kbp3IxpM8VgcyxzDXQPDIZsS/F459wEetD4O+igmXnkBJx4VM/Peog6JWOlsQSIiEMHthuusFQM2v8KLPemueMO3pzcqKCesmJaK7Lyz/H31zJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJcg0CjV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcg0CjV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38db0c06e96so1008410f8f.2
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 05:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762903; x=1739367703; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xFPvMTIko7RUlkglGsjRjisDlAMQ0L0NE9oHfkSjMWM=;
        b=JJcg0CjVma9yDXlJ6Y2dlbcTBfWKhdnmDQswcd97IBi/DtXoRRyPCTXuTAnesa+wr4
         5hKshX1WE8igACryrYzp7zLZFCXIPGcyszy1LOiAVXOL2hLxmYEzXbQ56S+6GsZihQQw
         vJwcw8ku2sRItETz/2MnqOL9pbkAK7y8hRfIrx7zw6kh3Z3tD/vYxEhvrHbBDvmplZTW
         0u3lvVIELrPxOtlZ03tEIhjT1AkA20IsiXg6rc30Yz81FTHxNoTDGmNlljYZN7asp8Sv
         bsx+QMT5dCWFcwx74PsYoLBZCsVG6/zeLYSO3d9xKgZUjstO/WiahLf3AeTKDIZbXkOv
         rJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762903; x=1739367703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFPvMTIko7RUlkglGsjRjisDlAMQ0L0NE9oHfkSjMWM=;
        b=sAMJlcigHrmNN78GzPoegOFQ9y+vBhHkF+kdD1VXhmQT547p7qVhZhSEjWrpKrcsx5
         nyIn4lSDkOY68h7rEeYmsB54hC2fMv8mkxzuFs7ieYyPox/uxTun7TKEoTQ06RLWF4uE
         rrU5eECkGw82d293suXraaDgXwcxd++kIbe/WBSSxVunjXeAd1g7/Vfb6K6qS5nDdvOq
         XXbcLs6g8MYanwE4HEtM80mk9erO8SrgR/PEHq3W63IpVC6dZcqrdVoM9rhvxt0Uigho
         cQK3UNjLV/a9G+71FMKlcR7qwjQF4x/wzZzgTXWHyqbejDJQt8cnwg670/Mf9ijCCwml
         o96g==
X-Forwarded-Encrypted: i=1; AJvYcCWD7ER3FPF0Qs8s/pCwIuis0bdbdjNjRtxUqLstnygMC7NYoFFXdgK9ajY5LBe10/3j2wK8NA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww8UKOUx1PnviRKme7hZ9I7wpLRYCdMc/W4XdO1WrY7gET4rRD
	fUnZ+trZ5TojjOrXgF49a4cQUh9XyFjDNifwAWQIACEy7MfQRsg0
X-Gm-Gg: ASbGncvKamXrRjLEWjYGm5RdU3bJmqE5QkkTAp8EIkvOkmUuYIYbDaDjHEYpnSzxNRL
	jJS9W3OTMrA1bnirwaUHpDxzkv4vhdp1zr2rzbOz+kaTRxkMzZs2jV/+VUZJwXvaFbo5fQczdRd
	w2Hy3+wNV/uAJpnB08QkB2skTFjMoEuRjUEPZzAwuiufFFvsVZ7Pc1DfgeIxhRJm+hz5gRG6O9s
	BocwgCv8+tcXhHFS9ZUM4bEsI60nQeAuemwmn7znqRbIZtnBvsmudovtum60DlNEHxt+lbtbcXM
	nF6vsIb5rF/J7CHK
X-Google-Smtp-Source: AGHT+IE41Ns76J3NfuF1YmTbO6rT4ejaawkIKve3VGyDmVrgZUVBLjFau3taVoNLAnv07S7U6/8rlg==
X-Received: by 2002:a5d:584c:0:b0:38d:a8f7:cb73 with SMTP id ffacd0b85a97d-38db48d5a24mr1971575f8f.40.1738762902640;
        Wed, 05 Feb 2025 05:41:42 -0800 (PST)
Received: from Red ([2a01:cb1d:894:1200:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf53asm18459418f8f.87.2025.02.05.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:41:42 -0800 (PST)
Date: Wed, 5 Feb 2025 14:41:40 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: iommu: flood of ahci 0000:e6:00.0: AMD-Vi: Event logged
 [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
Message-ID: <Z6NqlD2Je5xVtFui@Red>
References: <Z6CGzUSV7llweytQ@Red>
 <0e4c38a8-3f7c-4cbe-9dd0-9e73d4d947e0@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e4c38a8-3f7c-4cbe-9dd0-9e73d4d947e0@amd.com>

Le Wed, Feb 05, 2025 at 05:33:50PM +0530, Vasant Hegde a écrit :
> Hi,
> 
> On 2/3/2025 2:35 PM, Corentin Labbe wrote:
> > Hello
> > 
> > I have a supermicro server which is flooded of kernel message:
> > ahci 0000:e6:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
> 
> 0x70 means, Page was present, its write request, but device doesn't have
> required permission.
> 
> As Robin mentioned, it could be FW region. Can you please double check?
> 
> Also what is the failure scenario? You see as soon as you boot or after running
> some tests? Can you provide dmesg?
> 
> -Vasant
> 

Hello

How to double check firmware region ?

For other questions, I just sent an email to Robin with all answers.

Thanks
Regards
