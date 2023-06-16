Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071D6117
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 11:32:32 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso761054e87.0
        for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686915151; x=1689507151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nuyRQlcqUJ1I+sHmU3UQhaVpsWzNHbMeXA40SLBfto=;
        b=DH5R7s1yTiVsAJI1g99s6OalFVFW9cM5DAnNDqJJfwlRotOUA96IF3DT5skABPinz5
         E4IcsKOQ3I0Rl1kStGkLFAxRCwwg624eQLqtopcQdxXR3xBLUA2PpbggQ7ZzEgEqRcbe
         zLF4TFVCygtMwuugGFfMrYnwW9LYL8yD4irsAG/DyJmz0CufETPyYE1jSdmH8wJwQ6tx
         vSjOiWjZxCKLbz+1fw0d11obwbqVVFSHTsLjqc7E95c4rZrMb4MBr8n0fUJ+UFj2gDls
         a5bE+ElDJi7ADNbMc9uGiuwj+Q1wcaJHUu12vHRDhSs8Nb7M2gleCC8WcLdhD9mV7s2o
         YiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686915151; x=1689507151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nuyRQlcqUJ1I+sHmU3UQhaVpsWzNHbMeXA40SLBfto=;
        b=EKu6lE4C3/ojsB5V6Uac9Du6a36gwdlc5LZZVd8HeMl3sUOOZtxygFUPd3HPpvM2HL
         dk9rpw9nHNbB1/EUW9waVmQmEw8s1enlJsMQemrrT03bg3zXPcvUtW9qBQUKx+5hCIj3
         ENHoeobPCtPIBxfeLqGXrW4Jl8AUiMGmA0BR10FRI0L0sY71laZoDOxeFCkuvhEf4jcO
         Mglzp+Z87yaEOeKSvXhYV+XgJKUoZEl+1DWrefrVlmJMj145ldb1t+13MKw964/Tjm08
         HYwFvcWJChv2N1dFYZd9+Jh+f68Aaz1BwYLQk8ZAiELJO9GOTV40qfTECYQigA8lpeXg
         y+sg==
X-Gm-Message-State: AC+VfDwhFrbCJy/vSlZFvUKuUudCi7cvOo4q8G1xt+i1x6I3qNIQwg5J
	K6bUO4Hi5Vf5wAMl2Vg2pa5E0g==
X-Google-Smtp-Source: ACHHUZ4vwQur9icwi+r14RxKea4abemDipKgtryepasg7loeFJIpKxEcaQTsVhSGPpckiB9/VJ/YOA==
X-Received: by 2002:a19:4409:0:b0:4f3:b07e:7eb8 with SMTP id r9-20020a194409000000b004f3b07e7eb8mr1138136lfa.29.1686915150597;
        Fri, 16 Jun 2023 04:32:30 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003f8126bcf34sm1879491wmc.48.2023.06.16.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:32:29 -0700 (PDT)
Date: Fri, 16 Jun 2023 12:32:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20230616113232.GA84678@myrica>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>

Hi Baolu,

On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
> - The timeout value for the pending page fault messages. Ideally we
>   should determine the timeout value from the device configuration, but
>   I failed to find any statement in the PCI specification (version 6.x).
>   A default 100 milliseconds is selected in the implementation, but it
>   leave the room for grow the code for per-device setting.

If it helps we had some discussions about this timeout [1]. It's useful to
print out a warning for debugging, but I don't think completing the fault
on timeout is correct, we should leave the fault pending. Given that the
PCI spec does not indicate a timeout, the guest can wait as long as it
wants to complete the fault (and 100ms may even be reasonable on an
emulator, who knows how many layers and context switches the fault has to
go through).


Another outstanding issue was what to do for PASID stop. When the guest
device driver stops using a PASID it issues a PASID stop request to the
device (a device-specific mechanism). If the device is not using PRI stop
markers it waits for pending PRs to complete and we're fine. Otherwise it
sends a stop marker which is flushed to the PRI queue, but does not wait
for pending PRs.

Handling stop markers is annoying. If the device issues one, then the PRI
queue contains stale faults, a stop marker, followed by valid faults for
the next address space bound to this PASID. The next address space will
get all the spurious faults because the fault handler doesn't know that
there is a stop marker coming. Linux is probably alright with spurious
faults, though maybe not in all cases, and other guests may not support
them at all.

We might need to revisit supporting stop markers: request that each device
driver declares whether their device uses stop markers on unbind() ("This
mechanism must indicate that a Stop Marker Message will be generated."
says the spec, but doesn't say if the function always uses one or the
other mechanism so it's per-unbind). Then we still have to synchronize
unbind() with the fault handler to deal with the pending stop marker,
which might have already gone through or be generated later.

Currently we ignore all that and just flush the PRI queue, followed by the
IOPF queue, to get rid of any stale fault before reassigning the PASID. A
guest however would also need to first flush the HW PRI queue, but doesn't
have a direct way to do that. If we want to support guests that don't deal
with stop markers, the host needs to flush the PRI queue when a PASID is
detached. I guess on Intel detaching the PASID goes through the host which
can flush the host queue. On Arm we'll probably need to flush the queue
when receiving a PASID cache invalidation, which the guest issues after
clearing a PASID table entry.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20180423153622.GC38106@ostrya.localdomain/
    Also unregistration, not sure if relevant here
    https://lore.kernel.org/linux-iommu/20190605154553.0d00ad8d@jacob-builder/
