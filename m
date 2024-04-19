Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7C12C53D
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534912; cv=none; b=Kecvy0PA5rBzJ5wYy9m+yr11vjEsNVecBybQTGIZG0Eegj/b5miwraLJ3L1B904qfgsTpE0bkRd6BmCrGxXXnpX3OtzXnizDcdtSkCKLD0kkt72ipnv3ypvFJEX7iEW21q5PDfkxlVdHB4ZYyw0Afozzw0lHZ02HiqmlhRu8KA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534912; c=relaxed/simple;
	bh=35xtwLDOwMLSiN0iWProcPjGusx6q1ZiX+FpgyM+nVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4YfRQNaPyIwVTlmhQAm8QG6wzQoDoBgzQumCDR6EQ/fo7Ucqn2STmbB/nZyoKU0lojLFcWW9VWunMM+Mko5HgZSN9wLeWF3XTGE5mZaTQFW4Awp1cpKisrZusjJyjXhMt+7f4nmca2aRWhsQpbkERPT0XpMHFYURHNUCpfsAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyeSAbMi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyeSAbMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713534909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjqRpX+pS+vo3/Lr5IudRNzeQilnxl4tMq9R6OC0a+0=;
	b=PyeSAbMitBigz8lXWf/1gjs/paPcIwpG06loPGrXh7DjXjLykfvlsijBz51xOUfN9MjbOv
	m5u2zMs/EIy/65JEaNbDz50ZvarOeT0TrmQOgzSi6MBVWfGgVBcU+s14boO6z4msPgf2B9
	60CzWHOgw6OQWnF67qa6zm1UNBYk+/k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-sDPcIjLvPc2YBbp1T39Tag-1; Fri, 19 Apr 2024 09:55:08 -0400
X-MC-Unique: sDPcIjLvPc2YBbp1T39Tag-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso69662839f.1
        for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534907; x=1714139707;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjqRpX+pS+vo3/Lr5IudRNzeQilnxl4tMq9R6OC0a+0=;
        b=Uki1ViTwdT0MDeH+2mR+Pj/+Do55K1WxaPQr3KgHseA+X3nXLbpUWkO5UYdfqv+pe2
         IEOlFoP87R+RhBZwyCsRKrDI1nbJwbWH1uGAnZFF563T05IIwgbFNSytoOwBDANkPCX+
         QNQSdbZGRIidLMHxmSrIITYbkdKzVnjbsx6er351ROMk6yexwXEDZxpqbfmos6zv2UyC
         HMhCM6ghNy8k5MbfzRt7P8tyNyrmhu6PQOv8+3QIbHesUC8EqCmyCxB6H12St4ZkbPl9
         /80++0n+S5AOGnGTOHSP/TKVMvShfCHgeSpylctRvo50IH+RviZ7adte24iC0sjkEsOG
         86Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWOlBWkHhPJhUxSeRvM7858RHkE6KX4+H5P759LCtVazKlFHypIWOjQhn0m7BW2DmVokp/lYgBXTgsBRsBS58coPVKB/zY=
X-Gm-Message-State: AOJu0Yxk32r1DGPqFR+SYy+tftQLm2QA0Xtov5Du6xpkh8H2m6q5AIos
	G5kGgfafw46RjwFwScLdlRhwLoS/VcJGlHZ/1n/JTaCmSEuUzSb6AqdpkVOfrg6f4XvpZGjDKS1
	J0eQQg1bgd6YgMNhPJMRGHqdBD4LqhzfFidsJuHTDdpQhj2c/RYwa
X-Received: by 2002:a5d:8603:0:b0:7d9:e3ba:7971 with SMTP id f3-20020a5d8603000000b007d9e3ba7971mr2501129iol.17.1713534907434;
        Fri, 19 Apr 2024 06:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2IyxruJ6/BotipF2aVkllUgehptgnXhLyHQJtiyR1xz0obyh3STzQZCR7FRU+Jv1P9PumQw==
X-Received: by 2002:a5d:8603:0:b0:7d9:e3ba:7971 with SMTP id f3-20020a5d8603000000b007d9e3ba7971mr2501096iol.17.1713534907037;
        Fri, 19 Apr 2024 06:55:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ha14-20020a0566386b8e00b0047f1b5975e5sm1030494jab.76.2024.04.19.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:55:06 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:55:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, <kevin.tian@intel.com>,
 <joro@8bytes.org>, <robin.murphy@arm.com>, <eric.auger@redhat.com>,
 <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
 <chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
 <baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
 <jacob.jun.pan@intel.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] ida: Add ida_get_lowest()
Message-ID: <20240419075504.47dc3d75.alex.williamson@redhat.com>
In-Reply-To: <d4674745-1978-43b2-9206-3bf05c6cd75a@intel.com>
References: <20240412082121.33382-1-yi.l.liu@intel.com>
	<20240412082121.33382-2-yi.l.liu@intel.com>
	<20240416100329.35cede17.alex.williamson@redhat.com>
	<e3531550-8644-4a7e-94bd-75bdb52182be@intel.com>
	<20240418102314.6a3d344a.alex.williamson@redhat.com>
	<20240418171208.GC3050601@nvidia.com>
	<d4674745-1978-43b2-9206-3bf05c6cd75a@intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 21:43:17 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2024/4/19 01:12, Jason Gunthorpe wrote:
> > On Thu, Apr 18, 2024 at 10:23:14AM -0600, Alex Williamson wrote:  
> >>> yep. maybe we can start with the below code, no need for ida_for_each()
> >>> today.
> >>>
> >>>
> >>>    	int id = 0;
> >>>
> >>>    	while (!ida_is_empty(&pasid_ida)) {
> >>>    		id = ida_find_first_range(pasid_ida, id, INT_MAX);  
> >>
> >> You've actually already justified the _min function here:
> >>
> >> static inline int ida_find_first_min(struct ida *ida, unsigned int min)
> >> {
> >> 	return ida_find_first_range(ida, min, ~0);
> >> }  
> > 
> > It should also always start from 0..  
> 
> any special reason to always start from 0? Here we want to loop all the
> IDs, and remove them. In this usage, it should be more efficient if we
> start from the last found ID.

In the above version, there's a possibility of an infinite loop, in the
below there's not.  I don't think the infinite loop is actually
reachable, but given the xarray backend to ida I'm not sure you're
gaining much to restart after the previously found id either.  Thanks,

Alex

> > Ideally written more like:
> > 
> > while ((id = ida_find_first(pasid_ida)) != EMPTY_IDA) {
> >    ida_remove(id);
> > }  
> 

