Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5467107A2
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 12:58:19 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-62ff12ba965so30928246d6.3
        for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687179498; x=1689771498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EN8SHZPulgVB2NMCjQeN+NgcQzF+fy6eDxvPwaTnFU=;
        b=Dl0Yh3odU6Ibx3U0XI9gO01djO1boB8jD1cQR3R0NpzgPt5gPq9kihHCbswEzs3OYd
         03r5QSYG+lxEISoM2jRdnzGNx9ob6uaG61rTYKda/EyDE5OUeALFKJyKE6aRxEmqtMuT
         yq9zqGabHHd4TXbED/HDtpcORbbbp3Jla0hLbgo8RA4FwWaZ9I4u+bK3oDmxUf3qw4SE
         /6tHL/coP/TP6wYqZrSg+2tLJEV0+DPKoZNSpJOXcv047B3EDisC0wKL9JIHNiPJ4PL9
         fp3Es3PjT7hGqIIjPXQNJdzxvl5kP/uIXH9m3OZQg3WwYAGRQMJnyegfrhfSeGfNrXx4
         RuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179498; x=1689771498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EN8SHZPulgVB2NMCjQeN+NgcQzF+fy6eDxvPwaTnFU=;
        b=AqkpAN+ucB9PgXgg/8hI/CTw5AaNdeZHqwz+3zbfguj5ii9MBqCQIR8tn16t894fP/
         7GHrjIyXh2h11lZpRslaf4eToj/YfG3n91rXJOpA4h1NCoD+zdMPYq/jcD23NP94uVhP
         4JE6jITdpvKb2+21uUuHfB5iQKmnuDbTQ3T/xywgMlQbBNTCX/x1TlXGvPsYgIFj2Qiv
         I0q+BPB2uBU9FHR+hVTkLv5YsZiCtHxMcJd8A4nC4LM9Z+V2ZLF1TYBwicYzGsvPtd9Q
         kpvGukbB8ZPzMnvD0BYXPsssUQdk+thDbXWTOxSC9rIJ1w21bqsl2KAMEhM3UmX6ijvJ
         41Yw==
X-Gm-Message-State: AC+VfDwftnEmVjNBfTob4jT6sh7uQU8ALLs2w9d/5G8lC7oHBp29TFJr
	e+wKXmBy63YamonhpzMkcdUI7g==
X-Google-Smtp-Source: ACHHUZ7aEQ33ZOLHiW7qLtXGbpVR5w4OkoPZd7ZxPgLEVetaPWz6ZAVebnx2vcET93MTDfFQnhj3cw==
X-Received: by 2002:ad4:5cc8:0:b0:62f:fb4b:e28f with SMTP id iu8-20020ad45cc8000000b0062ffb4be28fmr12415239qvb.31.1687179498427;
        Mon, 19 Jun 2023 05:58:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id l5-20020a0ce085000000b0062439f05b87sm10534957qvk.45.2023.06.19.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:58:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qBESX-006pH5-Bv;
	Mon, 19 Jun 2023 09:58:17 -0300
Date: Mon, 19 Jun 2023 09:58:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJBQ6Qeg+C5wkhmw@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <20230616113232.GA84678@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616113232.GA84678@myrica>

On Fri, Jun 16, 2023 at 12:32:32PM +0100, Jean-Philippe Brucker wrote:

> We might need to revisit supporting stop markers: request that each device
> driver declares whether their device uses stop markers on unbind() ("This
> mechanism must indicate that a Stop Marker Message will be generated."
> says the spec, but doesn't say if the function always uses one or the
> other mechanism so it's per-unbind). Then we still have to synchronize
> unbind() with the fault handler to deal with the pending stop marker,
> which might have already gone through or be generated later.

An explicit API to wait for the stop marker makes sense, with the
expectation that well behaved devices will generate it and well
behaved drivers will wait for it.

Things like VFIO should have a way to barrier/drain the PRI queue
after issuing FLR. ie the VMM processing FLR should also barrier the
real HW queues and flush them to VM visibility.

> with stop markers, the host needs to flush the PRI queue when a PASID is
> detached. I guess on Intel detaching the PASID goes through the host which
> can flush the host queue. On Arm we'll probably need to flush the queue
> when receiving a PASID cache invalidation, which the guest issues after
> clearing a PASID table entry.

We are trying to get ARM to a point where invalidations don't need to
be trapped. It would be good to not rely on that anyplace.

Jason
