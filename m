Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3D3201
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681728951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wWR6LdExfwjEsSRDi6jXKipEXf+Q0zIDWbRNdZy7RQ=;
	b=LA7zYhjDS/oQF9/rcDrkkGntGnW+ebwCriv90C318xtI/qdBAgW48yfFHvMaNsJa0cXmKw
	VuFtSvKwg10Ms/xsUD3mVzfhViwl4tQ3AVKvtGiNKC+S90cjOY3FA2+6pBZrEoDbOILuCW
	PLrob+WU0Y7cjc7zVx21XkJ7fRoTmDw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-w1iL8snXPr61fSPaLOvPWA-1; Mon, 17 Apr 2023 06:55:50 -0400
X-MC-Unique: w1iL8snXPr61fSPaLOvPWA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f080f46fb1so5539475e9.0
        for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 03:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728949; x=1684320949;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wWR6LdExfwjEsSRDi6jXKipEXf+Q0zIDWbRNdZy7RQ=;
        b=jHJHPnLZwCNSqfte0YKKGqxY0yaDrLIcvPvTnRygLY1bY8tpeH/Kv1jhVHf+OtiLK2
         Dl9cUAaI+0dHknCWUSIBbl39o3w0J28WWo0DSf7RdtRCunEbTIDARtEJBVV9+Z1ZBKUk
         NPft7X0SiPgbRDfn0qCuAoE5pr+3on3L2MNACF7J6/DYozanK7V6T7qQyOjGjJXd/ETE
         fRN5WTPMXYupj1j3wlhrKYoBFKh5QS7atmb1Wfn254MX8lghLMd+nuf1tAChRGZs8qWU
         6yPyDfsaBZYgkVDsV5PznryeKMveXWfg7F/13t89/bOqQD5Oh2SnK79K0fOFEFvd3NEM
         TTjQ==
X-Gm-Message-State: AAQBX9dzFeHe5vXkz10TigP8VM3SKcxiw6UdCHs17QMcekrTAfh4opZ5
	Tz8RXFSfg8RdQ5nJtqooKeeZYFuyPxMSR46Aj9vxMY+vHqc2EFaKNbVZLCEnkXk10qvT7QjIB9d
	3Z4J6s5EOB5yuJ3U=
X-Received: by 2002:a5d:564a:0:b0:2ee:fc1b:b7ba with SMTP id j10-20020a5d564a000000b002eefc1bb7bamr5554694wrw.39.1681728949288;
        Mon, 17 Apr 2023 03:55:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350b4mqRWHxHUhRiKtx3CxYgUioujgL380Qdaxi7z1qv8uqaf0xsSOnV1ktQrpGXmyp9r8e6DcA==
X-Received: by 2002:a5d:564a:0:b0:2ee:fc1b:b7ba with SMTP id j10-20020a5d564a000000b002eefc1bb7bamr5554664wrw.39.1681728948942;
        Mon, 17 Apr 2023 03:55:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003f16fc33fbesm5319894wmr.17.2023.04.17.03.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:55:48 -0700 (PDT)
Message-ID: <887ad211-b63e-5f04-9a55-66027a8dc1cc@redhat.com>
Date: Mon, 17 Apr 2023 12:55:47 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/7] mm/gup: remove unused vmas parameter from
 pin_user_pages_remote()
To: Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 iommu@lists.linux.dev
Cc: Matthew Wilcox <willy@infradead.org>, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <59022490ef05da7310e6abd7f42df933bebdda2a.1681558407.git.lstoakes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <59022490ef05da7310e6abd7f42df933bebdda2a.1681558407.git.lstoakes@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> No invocation of pin_user_pages_remote() uses the vmas parameter, so remove
> it. This forms part of a larger patch set eliminating the use of the vmas
> parameters altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

