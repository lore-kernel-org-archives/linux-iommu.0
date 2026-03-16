Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC139FCB9
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675814; cv=none; b=oWQrbhRc5xFsT2cdQ8E5bQJnibru3Xc+h/bcx8/2la7DfOH/9H0hkZ9kayK2dNJv5qCk2QnwFR95PFGXoDh0eu1mTfnrj+GWY5XVg0Y7h1GJhDj+Rw5pvFM81ey9AhJWm04nSW2Jx9775DK4VheKmJhEKCcU9eAsMdVQZL1HvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675814; c=relaxed/simple;
	bh=qnnFKEgSuePVgJSXdU46MBshBKsJgWkb7W+gg/dmsoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EOBmJQbuDBuEpVe1I39cxJL9hQANBfydgNE4JZ9vm1giXZ4zoBEpQpXc22PqzxNSEM+DGh8ornW8PEjQKVQQE92wJvPVg/NDbX79F4QKdCr5jsizSmWZ70Xc7swyYANfH6B3OpH4xnXs8Qt2B2yTeJGUOwqkKSGlYh2lMehyNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keL6+OIh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keL6+OIh"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1949905a12.3
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773675813; x=1774280613; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUJsBlIgUApje1fV9jF7YVlGvh9bq+NPczCyWOUxzn0=;
        b=keL6+OIhP1DxVZyeiAqe25K+ogrmczQPiYE7BiZfO58YBDvoPfC7GVOUqeX0TtKYVM
         oXm5cDEzJEF2bnmQ17JlMXdNaR8+KAyCcf7pAE4Xh6oXABsH7ngkceiInIUuNpPNiRTK
         QzqvTZLakqtlI+lr2TxneRK0V8IGkduTIBbby5N2rf+VnldDWZyxu8/EAnW2MhKlZV78
         HdrIq43kXEFR5xLXWRacKtY7sb6mvxPgaTOzwUV9vXjcg9ADIna78I4G4oVkmacky59W
         1BoIsT/trwpYHcIb0LNDfj7ZbfJwbC5tBO45Tf6C2uadAhnsnWuDzkvZxe6PtjN2wHzq
         jo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675813; x=1774280613;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUJsBlIgUApje1fV9jF7YVlGvh9bq+NPczCyWOUxzn0=;
        b=h7jmfPcw49m2blR0SqPy+cT3vEkTrXH13WNIuqUbQTDQUQilSUqtEWJFhO0v5bM+P6
         6Jg3X26R1xzTiCsYih3U7XP+hQ9yXvBvSHdBySPvnV5TgQ2JGZGMGHRTWfU7l6WmskeX
         HxA85tj4vkCapHagjwNvaUpyqUOBup+FMBzMUyXgf3M21DKFN76DIfKtLGMTB+SzkcID
         JiI76LdGsoMRTDFmtOBsjcLtyEyj6t4ALoyK1hOD8nnzwPyp6i7nf0WDnpY6xYTer1rX
         T+w27V6BtQqF4iDyyQK9FIlG7AarcJd5nYFsMPJJp5lixdEW1wmgL5PVoUtr/dVHMUrG
         cGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDhLfb2kXFcsFgHUDzpAALuJWP111+w5vAhHwfbFJx2kaSABQJqxVRkZvOvxlLtk75PbTNyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwiZg2l0SnxqWAre+C1tguDRl9NUBzfyiHQnCdOYCMblbarM1J
	hfdXtTlWx/7e81VF0YtALva75OTvZLTtmDsh09t5y5IrSIj6JrZ9O7Yq
X-Gm-Gg: ATEYQzwrmUUlZPR/s61ZX5Q0tFxJ71RwuuZKOJbyEbA+y0jLZ0NSI4wx/+kTEMxxaNQ
	WCBGslSBFZtYNHkBi20qD1GzFlfR8acqz9f9lGwKBb62euTdN1z4T5bbKk8aPam2OZuJ+XVp6Me
	QY4c8uzt3A6BrjSHFGYfBCwrrQX8BDJoMFjyOgmYeKcZNjLHXDaK5z4tRQDbPQgLudT4p1ZPILV
	nyOF6yQrT6QzfPHcTNzBVwZdUh+mJ6Bv93NWpvmi9Ugtn5T0QUq/xdGCBpK8UW9wUvs0nXEFYO3
	d3FtRASojUc3XThMQKuDh3osTZXaVz//cDckcMZ9Wosg9H9F1Y1yI/bdhGCK7Slo8G2QP8rFa4o
	EGba2TzsmH/CG+bCMSl1T0h5eOA5bXZC4dPH4ejMsAeqdXpV+lCjJeuqKXbJK5OtxZGDVffxTAp
	K97kHzirqyCGOu9EohJ67fydscXF3W90lrPWx53jC2FEKM+Dc5/UHTn2QFPfgzyd/fjQOHdPmE7
	NbsmyLP2woX8xonECm3iPAM1WfgVwVhbVhF
X-Received: by 2002:a05:6a21:2c12:b0:35d:7f7:4aac with SMTP id adf61e73a8af0-398eccf5230mr12827288637.47.1773675812990;
        Mon, 16 Mar 2026 08:43:32 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb996257sm9417128a12.9.2026.03.16.08.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:43:31 -0700 (PDT)
Message-ID: <b25ebc98-8697-4f1c-989e-fb67d9dc6713@gmail.com>
Date: Mon, 16 Mar 2026 08:43:31 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
From: James Prestwood <prestwoj@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
 <20240815171935.GO3468552@ziepe.ca>
 <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Content-Language: en-US
In-Reply-To: <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/16/26 7:58 AM, James Prestwood wrote:
> On 8/15/24 10:19 AM, Jason Gunthorpe wrote:
>> On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:
>>
>>>> This is probably the only way to approach this, trap and emulate the
>>>> places in the device that program additional interrupt sources and do
>>>> a full MSI-like flow to set them up in the kernel.
>>> Your last sentence here seems to agree with this approach, but
>>> everything else suggests disapproval, so I don't know where you're
>>> going here.
>> Trapping and emulating is fine.
>>
>> My concern is really only about skipping SET_IRQ.
>>
>> That works because of the assumption that the IMS sources are going to
>> re-use addr/data pairs setup in the MSI CAP.
>>
>> That assumption is frail, and won't work at all under the proper IMS
>> support Linux now has.
>>
>> I really don't want to go down the road and have someone tell Thomas
>> he can't convert the Linux driver to use irq_domain IMS because it
>> will break this stuff here.
>>
>>> I have no specs for this device, nor any involvement from the device
>>> vendor, so the idea of creating a vfio-pci variant driver to setup an
>>> irq_domain and augment a device specific SET_IRQs ioctls not only 
>>> sounds
>>> tremendously more complicated (host and VMM), it's simply not possible
>>> with the knowledge we have at hand.
>> It seems like you have reverse engineered alot of the necessary
>> information though??
>>
>> Maybe there is a more generic approach than a variant driver. If you
>> wanted to use IMS from userspace generically you could imagine some
>> kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
>> needed irq_domains and pass the addr/data pair back to userspace?
>>
>>> I observe that the device configures MSI vectors and then writes that
>>> same vector address/data elsewhere into the device.  Whether the device
>>> can trigger those vectors based only on the MSI capability programming
>>> and a secondary source piggybacks on those vectors or if this is just a
>>> hack by Qualcomm to use an MSI capability to acquire some vectors which
>>> are exclusively used by the secondary hardware, I have no idea.
>> Well at least that should be testable - but it seems crazy if the
>> device has registers for an addr/data pair and then somehow doesn't
>> use the values that get put in them??
>>
>> Copying from the MSI is almost certainly a SW hack because IMS support
>> has never really existed in an OS until now. I think your guess for
>> why it is like this is pretty good.
>>
>>> I do not believe that introducing a vfio device feature that disables
>>> virtualization of the MSI address/data _only_ at the vfio interface
>>> (not to a QEMU VM) provides some implicit support of this device
>>> behavior.  These values are already available to a privileged user in
>>> the host and the same is available for an MSI-X use case by directly
>>> reading the MSI-X vector table.
>> To be clear, I'm not really worried about showing the data to
>> userspace.
>>
>> Userspace just shouldn't be using it to implement an IMS technique!
>>
>> Jason
>
> I see this thread went stale. Wondering if there was ever a final 
> conclusion if this could get fixed for ath11k or not. I tried again on 
> a recent kernel, 6.17, and see the same behavior.
>
> Thanks,
>
> James
>
I addition, I've looked at various kernel version and see no time where 
there was ever a "hw/vfio/pci-quirks.c" file in the tree. I tried many 
versions between 6.17 and 5.11, I don't see the "hw" directory at all.

I'd like to try this patch out, but might need some guidance on what 
kernel version this was meant for and if files may have shuffled around.

Thanks,

James

