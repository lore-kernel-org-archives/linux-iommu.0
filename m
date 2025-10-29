Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68E266EFC
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747871; cv=none; b=OJKBWxy+4Rj9EKxxSs8SoKyT77MwM+RznUUHGjePshp+Yp5jPZAueRGWLlaK29YV13nTikKR5k56D/iB0h67huERbbI+BcrnbGXig6LZ+u7R6n9A3q5tc2GMQ/wGFU/ttMv2EH+qPngCtu2du5cGSqxPDZ6d09aBTEl9ttRAOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747871; c=relaxed/simple;
	bh=qS5ti7OtwVEPt76zXgfefM6TFVwnuYoF/S0givgkQgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6w2PaX2h2oCXj9MQ81balgQB6nk7p/Dc/t7/QS8J9jZA3U5Wwy7olEHjMgFqRwbsxDjusI/qkE6FdFX19bUBTn3kX5kz0RzWMuGDj3+kwl7d3lbghCjPw7rRs7x4qAdDQE1jEBsBR/srlYPCN11H1VjoZxGDTKasmTi3L4dn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjzcLPDd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjzcLPDd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so55495e9.1
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761747868; x=1762352668; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lYw1yzHZtok63cidNSQI3kNDGCJ3YniZmqixcpLm82c=;
        b=AjzcLPDdgJcuen2ftTGBbYi+G6whaBpA97SssdKB2fQlib9Gm7FuzNpIq76gspNgjF
         arQS+GoDgZxusx83rfRzBCT61sU2b2P8f7VMGfwfmIu0bo4Pk8XTeEyU9u/FvY+6foPh
         B/m8N0lMichTJD2eQnALp0HWk5pqeIh57vgjL+gNoRdryHhSBceynPWptf1XhhmNxZXT
         BPw5QSSCdwnv/sIkyQ63a3GumWi2rySMnWqXsvlkZleM+pEBInLdWNme/Qy3Eq9PJ3Rp
         Esm11E3FiIxyJvv+k9f3zwpR7I8DRkWhjaZCH7p+i1ONX5jAs8Gvc+W+uoX4RBX6D2Gw
         3taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747868; x=1762352668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYw1yzHZtok63cidNSQI3kNDGCJ3YniZmqixcpLm82c=;
        b=ZDbLZIK1oL3hg3h3afXlgroiKWB/kVbiXfmVuKkgZiB2LzDeioqAXkS30/u4rcI/hQ
         rDXnBuNSiJFOCLuZUHx3vjMz4qhbNs1WBmkNsdm7uhyB0t2/wHi4Dq7YE0urhZ9/39e7
         FYfay7oGVznJ8bLw7z4mbTtev4B+p6GLiCMOftcpyY5bmyObPYZ+0aG4sp6U936DyMZV
         wK99flZiNyIA003QZ1/UkZs2g5nhQoaX29HEVc84fWJFdU1ONAcycTTBWHa4bFfiX6we
         5uhi5ZVzfvBSvyX7nZZ4W95ACdCUDwnx20EnxO5L579JdrRmHK9hNsbc0eR2UsTmwkmz
         wyXg==
X-Forwarded-Encrypted: i=1; AJvYcCWk6a5KbUYWxz5XjJA6Y3NVMSLfbU/ug6CP3OAlYbJG1cp9HMUzmSUPlBhOeHpCMckKTp2DBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgsTBUhyNvknlwJL7TRvgnyiDHUN9PP8jgVN+ttwHjrzKxPdaJ
	PCb9J5UiWXMR/dbWdGBdgmXbGMZtNv2hj1o5Jw2ofIf8ZuUofuP/3gHOz3n3Hd3Nzg==
X-Gm-Gg: ASbGncsfdOWatWGPuArlihWAjMDfhPMdGRCmsw6eSiRY6pE9YPryL3GUJvzjqk0yCSh
	NGw7jVnh8gcC/9oAaD7oBYyKX4SkoWQPdlnjSIuZeALZRIzTdKO3mep/TFK/bDPo4sWrtavdUBh
	UhfU7YaAeIdbBLr8ezUv+OFYcbXdvVOalMVkPf0JT+PDWoaf2zh0O8g4zC4neVbCufmgzdpENag
	7zyP0J8hWek2OoQCK4zXhKh08ibOshoWTGJamHiXh8fPqubnmK2G4AzR57V1RX5RZ94Hdwo/nJW
	AdgjpEtnGuVycYeMaEHxBLfzKq5Db5zuEGAgAj5el/noLUpZwuO1K/uEuI4kwSUfx8u0YJ6nAG/
	/TbnGjqx8T7Va1w5/STXm76gku5rvYiHFYNFkPvOz1R2zZI3JouoXz24JR8m7Y0eVyvjERBMeS5
	nevy0CuracrplEd14M+D+E0+RMw4zIsUxG6hjMulmEVuUdwI1OUg==
X-Google-Smtp-Source: AGHT+IF2w8kCzWJz2ny6yJjbrSOF+2z2doPlN+BMk2LktbvxhoCGI/5la8r3PEhEpY5MyiFPBKRJew==
X-Received: by 2002:a7b:c054:0:b0:45b:74f7:9d30 with SMTP id 5b1f17b1804b1-4771f2ee429mr1618205e9.1.1761747868039;
        Wed, 29 Oct 2025 07:24:28 -0700 (PDT)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d514asm26815984f8f.23.2025.10.29.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:24:27 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:24:24 +0000
From: Mostafa Saleh <smostafa@google.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org
Subject: Re: [RFC PATCH 3/4] drivers/iommu-debug: Track IOMMU pages
Message-ID: <aQIjmKSH8r8U7uMa@google.com>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-4-smostafa@google.com>
 <3ajy2xcjo3t6xdrbeo5xinlwtxzujvx4plzk3vqj3za7ren2rv@wdmwpjlaq6ql>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ajy2xcjo3t6xdrbeo5xinlwtxzujvx4plzk3vqj3za7ren2rv@wdmwpjlaq6ql>

On Mon, Oct 27, 2025 at 12:46:02PM +0100, Jörg Rödel wrote:
> On Fri, Oct 03, 2025 at 05:32:28PM +0000, Mostafa Saleh wrote:
> >  void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> >  {
> > +	size_t off;
> > +	size_t page_size = iommu_debug_page_size(domain);
> > +
> > +	if (!static_branch_likely(&iommu_debug_initialized))
> > +		return;
> 
> This still adds function call overhead even in cases where iommu-debugging is
> disabled. Move the static_branches to the header files as well.

I see, I will fix it in v2.

Thanks,
Mostafa

> 
