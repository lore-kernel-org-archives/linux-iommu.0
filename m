Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DB107A8
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692982908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ2tJi24zuLFj3A+pu+XP5QHGUTmirfNDkb8cZUXPw8=;
	b=AYMKd+JY4MCbi35KIcC1gRfVfgTIenEDccJqyFf2UrxXJzfM+HG83ZoFlrRoSnmNLPnvCe
	wsDd14XOZ46V12MTHqars0iEJShvTEYmqzuU5xZHRkAznsbvffOCbOXdVkD6SYDhcvcZ2y
	ZR489CwCBzNoK7harSY8qyiDP9mnHbA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-vZ3P5oGUPOinXKsbkriKPQ-1; Fri, 25 Aug 2023 13:01:46 -0400
X-MC-Unique: vZ3P5oGUPOinXKsbkriKPQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76de9c1d13cso118567485a.2
        for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 10:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982906; x=1693587706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ2tJi24zuLFj3A+pu+XP5QHGUTmirfNDkb8cZUXPw8=;
        b=JbPIe386Nm6uEH8B/H8fr+sIDSMCUuDQI7x814yvkFHcPTkW2GLNVsPGWgAsMPWdu9
         8ShfyylR6804WLwmbxAWeg/SqRzBUpW7hjVhwaKzB6L5BPHp7EAgQTDtxsVkEMqMmQeT
         DITGqMdgyz3eAyrk0NN4zevA/L30HuYd9NS0cfHiZyDEreElktYXtJCeVMBVo3eumTYg
         0Ih9JZYhXv1WxZuMmFC87+nN94NMH0cxP+ZGQIps+i5JY9ze+477dUuh/2JSE6+8hsvd
         tNOSNTDhexInwZA+24amg1iaEvnT2dDDDlk2TuDSKoSD5l6qCZTJswJ/VkgtawZN3AdB
         VQxw==
X-Gm-Message-State: AOJu0YwoyBdrDhp1tv5TGiVOUiETPIiFs4Gj0IGxH13HNXfKp4brerhM
	LewPAucCxIPEWYf/zdur4UAMBzl2RZTsKPecTfjr7rBzTqo7+juPG2NeT7Pdgu3mQDmIFSKrmEp
	Su/nsbuXZlgSdK6o=
X-Received: by 2002:a05:620a:4512:b0:767:3a10:d6de with SMTP id t18-20020a05620a451200b007673a10d6demr22732099qkp.58.1692982906148;
        Fri, 25 Aug 2023 10:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9r+hgC07ICJNI/lmyGO6j9NPtPE1qa1auLnJ7Ql2oN7fd3LKPda8+yzOutuYVdg7B7oo5aw==
X-Received: by 2002:a05:620a:4512:b0:767:3a10:d6de with SMTP id t18-20020a05620a451200b007673a10d6demr22732079qkp.58.1692982905906;
        Fri, 25 Aug 2023 10:01:45 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g24-20020ae9e118000000b00767e2668536sm644165qkm.17.2023.08.25.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 10:01:45 -0700 (PDT)
Date: Fri, 25 Aug 2023 10:01:43 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhangzekun11@huawei.com, john.g.garry@oracle.com, 
	dheerajkumar.srivastava@amd.com
Subject: Re: [PATCH v2 2/2] iommu/iova: Manage the depot list size
Message-ID: <tfub6qlwprlwhvbuyfzhiqbsdbnzlbnhmteb4xcqd7crrrmopd@2eotamfjn5t6>
References: <cover.1692641204.git.robin.murphy@arm.com>
 <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 07:22:52PM +0100, Robin Murphy wrote:
> Automatically scaling the depot up to suit the peak capacity of a
> workload is all well and good, but it would be nice to have a way to
> scale it back down again if the workload changes. To that end, add
> backround reclaim that will gradually free surplus magazines if the
> depot size remains above a reasonable threshold for long enough.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

