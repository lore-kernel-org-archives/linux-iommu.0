Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDB3019D0
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447750; cv=none; b=Dqvj/dQAsW6PEOmI+Cg6EcLlpaXgtKbpYyDMnJAQT3XgSwA18oMgqEyTcsbRV2IsmujKNoqQ/m2IirZFg9TD1NxjRxkzjfM8DLorJSmOVzyIwKsIk760Qsu+R747vaoeChgE3y6Jj4l+CXvl7LNiRt+bcoBk3nIoJSfTVZQFSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447750; c=relaxed/simple;
	bh=UBTwN9epOeHMQdtzqaWFx5uzJ4dIDcreN1C53Qvt8jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrK5k2KM9f993LiJADskVaUAImYN9Zvka3fdaW9QT8bgcqOyAcuZzISEup0G0AHdHvnTzoUIcFkKHixjDDxaxo9Z2wTaWvyXoi6QZlQX4dzbb40qyBpng+OnjehsmeZq95+wJUJvDzlk19/kKfttQeq16wBVcV/dexUtNvUX0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8BUWrtY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8BUWrtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757447748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwEaYTkppqVE2bssVNAxlDikzdrxi/t7gGAUHOOn71I=;
	b=N8BUWrtYCQn2ENL2WYj3KNdAOVBlLw4IuPeTC5WdfMlz5vMNIOgWFV49Ad/Af2FGknBiQ8
	y4sNXY2KKwS8ulImht7eBDPuc1SM7bDo/uF3T+UJGHhVcTe9EKi8+5xbjHYCEnG0/qKMmc
	chjV+OOxQZb1k4oPM+0MPB/HGIdbDcg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-aX0zYZclM_S3gJxnSgnRQA-1; Tue, 09 Sep 2025 15:55:47 -0400
X-MC-Unique: aX0zYZclM_S3gJxnSgnRQA-1
X-Mimecast-MFC-AGG-ID: aX0zYZclM_S3gJxnSgnRQA_1757447746
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870315c98so2325766385a.0
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 12:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447746; x=1758052546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwEaYTkppqVE2bssVNAxlDikzdrxi/t7gGAUHOOn71I=;
        b=p88mEo3J5e9gY/gvfKtUzn9BphMyZE6D64QHXOuAyrjfn1L8QrX/mzANEUXpUhT8pr
         B1ZwyAn0eJAmziNkWjtEuusjsfZEn2kEQmT9nSXi6bIPCwZNpUajrQcmiL6Uvq5ofATa
         KzHkFbFfGWG2xZx+RLDX44Xsj4UZsfcJ6FZ88q+MoaYf+CA308LJT2Hklh7kI4qE7zee
         +EqYlHg6UZzy2elpkCGSsu1yLOyAzzesTelRuVFkc9lTPYRTO9NpszRCuEV0638mYQuf
         XUWpue1tmnK26Uwthz/p1LGJ33Ps5e8oNzrly5UcKilPVWk31ZTqd1jy6gq9WbJpxO28
         iUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLG2XIp6H0W54Qudo1C3mAi+tm+iive6OB5wkHCFGkG0L96tjPxBoWjeOTw5AGd147Kyqh1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB65qQspSRiNiurf8Cg9/VZ1qhF5Nih5tRxkk3qzkEhJSW4If3
	xSwMtd2R4QkqcrVk7t3nWtj2h3xikuj4AMJQCRWJJ8UWODOkHUSa+XteJhKS6lC0+vEcLYtzS8m
	sPWibRcddZjQv9Bxwg5toLFbbEYCPk8V5ohX0FTLdwn8el7VknEm+s21y
X-Gm-Gg: ASbGnctXZ0H/ebXn+fSGUjHjZKBf4Xbz7W4oyVB5XyU5rwwl4ehxstybkIpETTxGzS3
	UpCf+JselM0v8l5t1FGrFueDxhfYMcKUOZrJwzyyU/5cMb44PZyRrJqa70fsWrU9rT9UwbMpmEi
	qWF2ftvcAa+WhdVEpvk6feVpn8LBF74JhG5gNdWRtCXN7vymNsxy1/wKCvpSU6SHq6mpPjLKRVs
	SKAf5eWj7/iRA2UegwEO/r/Gj7O8cA+ZVBdgFiHK3kcir2XR+iApwq/iI01fyUR++YcJ3EbSXGO
	Lu1m0jJ+lpbQuT7J4xH/xPAHHyB41fCrF/kYv1hC
X-Received: by 2002:a05:620a:2695:b0:813:ccb9:509f with SMTP id af79cd13be357-813ccb9510emr1236086385a.5.1757447746529;
        Tue, 09 Sep 2025 12:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaAcXU8kXFobnNvUqNWSUsQz0woT7+jL6jE0MUCrwRybPYjUTXel6RI/GHw+5Xzip867Mnsw==
X-Received: by 2002:a05:620a:2695:b0:813:ccb9:509f with SMTP id af79cd13be357-813ccb9510emr1236082685a.5.1757447746092;
        Tue, 09 Sep 2025 12:55:46 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73a16bb3ff5sm74385076d6.1.2025.09.09.12.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:55:45 -0700 (PDT)
Message-ID: <25676d12-57f0-4f54-8554-a6d77d2c6631@redhat.com>
Date: Tue, 9 Sep 2025 15:55:43 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] iommu: Compute iommu_groups properly for PCIe
 MFDs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <6-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <d0a5052e-fbbc-4bb7-b1cd-f3f72c7085d3@redhat.com>
 <20250909133128.GK789684@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250909133128.GK789684@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MCmmv84j_0lsltkCe6sKS46X6RvGbCM-0I0kHZYPbD4_1757447746
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 9:31 AM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 12:57:59AM -0400, Donald Dutile wrote:
> 
>> ... and why was the above code done in patch 3 and then undone here to
>> use the reachable() support in patch 5 below, when patch 5 could be moved before
>> patch 3, and we just get to this final implementation, dropping (some of) patch 3?
> 
> If you use that order then the switch stuff has to be done and redone :(
> 
> I put it in this order because the switch change seems lower risk to
> me. Fewer people have switches in their system. While the MFD change
> on top is higher risk, even my simple consumer test systems hit
> troubles with it.
> 
In 'my world' I see -lots- of switches in servers.
I don't disagree on the MFD being a higher risk, and more common across all systems.

> Jason
> 

poe-tay-toe, poh-tah-toh... It gets to the end point needed.
Thanks for reasoning...

Reviewed-by: Donald Dutile <ddutile@redhat.com>

