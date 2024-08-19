Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390047F5F
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091326; cv=none; b=NPC5bTqXubZHrBVjqBVQZ0W07KDjbE/sDqr/ZxO+UOhQ68euACNtIYXUjupTp2ml3pzSmFmJhjIqRhIWPcOZd88LUb6ACCtkbHauWEcvZcxjVOob0+wGq6c10S0datOEQvjREFqAM0SpO1FWAyepMw/kIeewqAbO8hsVYh5ST9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091326; c=relaxed/simple;
	bh=WlUaJPEO53FA+WTRmjIZn/wxEwMtAVwhilaIZgSekdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0krGH8JX24sTc0vbkKIELpTP7DwQnWidqvZc4n0SuWagLyDD8jPk07De174mceOjQDLxw7nnHBmXmFwuyUlund343b82EiNk1iXBEHUYuep2bW1myIOjXIUX+EJA+Xgjg2u8Bzx0NpPtUgRbt4zMS3to5GwL03sf72qfxiNBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP+bGK/O; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP+bGK/O"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso3219240a12.3
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724091322; x=1724696122; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXJ/JxTQWUx4WEp9jXZ6KZTIfAGcgAjkGtJ6Z4ID9VE=;
        b=gP+bGK/OyxF7rLue3qsY8guFLdnaWw/aL0mj49oXOpov45JIkGCMYXtJoLVhDnxGBB
         Wn/8tgTJ0+yNqzDpBGPMy7BFtFbEb5yH4JVPVOxoJMDvQ83jZmPVfn9P4EpUFXduDcSR
         uFzAQ7kUxoOUk9cLJGNC5vjzBpmyACJAWC+Kv5BdoMonOHbTwj3zpfjVrjc21G3e7MBb
         hLID3NKKo3CNwctWlQFNZEtrEkYiRhP+LISNELYbEAdxy27bcHpJi86BCAwmQ6KnzeqC
         5S8aKflVlil6wIybdNDV2xDAycVxZOluFS2dRrqXaREq9A4xmKsuEwxM4CCWJv6Y3YgF
         oFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091322; x=1724696122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXJ/JxTQWUx4WEp9jXZ6KZTIfAGcgAjkGtJ6Z4ID9VE=;
        b=W4fl2ystzVvkP1y3uAnIrmbFGBhtyr0UInBoxbv+hSYHwsFuxfLtDfI6LeKV43i6jR
         aZp18XOOromDg72BwwN7WKJ2rPNZBkKsV/efOb9j4/pqA6aJN2rohbyfNnf3GY7CGnOH
         5WiY9mD3SJZAZp8bh5zLeif1pZ172bwdSEJsoahb0b+9x0wumbfl2JhEAuikCDFmMdj8
         uhqUHctiK7kUwSRQj0j199HLyDlpRXBRBrFGHG1wQMdR2dOex9FplLwXERA2LzO9hXS5
         1L/38/CTJr5Y4wp4Jjl5oKARFQgyVSWMYlRJpLt/cz92SwP/DxBuh9BA2v2QBAgzSUgO
         atAA==
X-Forwarded-Encrypted: i=1; AJvYcCUXo21XPT0eUzTOf+7kaWF3Rw/QBD5gSfmISvlVLpX28Zi62CRoCpdatmrLKXbEhH02OBjw44BAmgUYu7xkBaMjR7tqZPg=
X-Gm-Message-State: AOJu0YyUBlt2+k25Dtq8Oe0JbqK7tjRlKnXRIblxAWu5/vbjBUGh3Mbb
	UhS2DdOoreP3jN2wl2+zmxzIYqinlKflVSFSAH0lxdAPfgNYKOBd
X-Google-Smtp-Source: AGHT+IFc0po3mo4O9fpfmCnNRPHDYRjKwDTdjNmK8sh/+kEbHxstRUb///5F+1qJ3wH6KwvLikxDvg==
X-Received: by 2002:a17:907:e2df:b0:a7d:a031:7bb2 with SMTP id a640c23a62f3a-a839295605bmr878537566b.40.1724091321672;
        Mon, 19 Aug 2024 11:15:21 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d00f0sm656546266b.87.2024.08.19.11.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:15:21 -0700 (PDT)
Message-ID: <e937e26f-038a-6d01-76a9-76c86760ca4a@gmail.com>
Date: Mon, 19 Aug 2024 20:15:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] iommu/amd: Modify set_dte_entry() to use 128-bit cmpxchg
 operation
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19. 08. 24 18:18, Suravee Suthikulpanit wrote:
> The current implementation does not follow the 128-bit write
> requirement to update DTE as specified in the AMD I/O Virtualization
> Techonology (IOMMU) Specification.
> 
> In addition, the function is used to program several DTE fields
> (e.g. stage1 table, stage2 table, domain id, and etc.), which is
> difficult to keep track with current implementation.
> 
> Therefore, introduce new a new dte256_t data type and a helper function
> update_dte_256(), which uses two try_cmpxchg128 operations to update
> 256-bit DTE.
> 
> Also, separate logic for setting up the GCR3 Table Root Pointer, GIOV, GV,
> GLX, and GuestPagingMode into another helper function set_dte_gcr3_table().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[...]

> +static void update_dte256(struct amd_iommu *iommu, u16 devid, struct dte256 *new)
> +{
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dte256 *ptr = (struct dte256 *)&dev_table[devid];
> +	struct dte256 old = {
> +		.qw_lo.data = ptr->qw_lo.data,
> +		.qw_hi.data = ptr->qw_hi.data,
> +	};
> +
> +	/* Update qw_lo */
> +	if (!try_cmpxchg128(&ptr->qw_lo.data, &old.qw_lo.data, new->qw_lo.data))
> +		goto err_out;
> +
> +	/* Update qw_hi */
> +	if (!try_cmpxchg128(&ptr->qw_hi.data, &old.qw_hi.data, new->qw_hi.data)) {
> +		/* Restore qw_lo */
> +		try_cmpxchg128(&ptr->qw_lo.data, &new->qw_lo.data, old.qw_lo.data);

You should use plain cmpxchg128() when the result is unused.

Uros.
