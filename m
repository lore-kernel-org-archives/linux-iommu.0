Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493200;
	b=pD0moeWxcu/pWzCrfcrnqk88BenshcjYnoDtFYn0SML+kolrTfyKKrFBvs/LXzSrLIF+
	 4ofheSMtmyIhPbz7ggJ6jG1SjwpzBGNQkhYI2scpGJcbldDQNL+6KS7k2XOZWFsNWtngx
	 BtTGfRWlewHqn9bYtddIbpzRaoXPv5IIRR+j+jh/kMldCTnaVN7tUqtoIxampDXFLeu03
	 jUHgvObmFZdgLrBlGMr92BEIfVsV6hECYQMfqTEluep25bff9CPOzoiyALPeizkoWN/me
	 OXKa5+5Se1oWj4DAZg1kOubzHBZXsJfBIfytJP5DJmv+5ZozIyiOwq309yCSVvFIidA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
	b=UCunuDp+ty4n+QHeZKr7vrbNIY7Mgrcssq5E6uJyH1Q9qjbO5jdd29loBeS2tIMgyxOA
	 1vCAQSv80EjvegnC7QMZWSoOoycwQ5xE8qr8U3xJBagxKbDeSRLecjmXvaanIJPze5b05
	 HXC/AhOEyDjGu+XVpPQ5ljj9Y+DqQ35o6AunzeV/pV65ObeAS8At8AaXeCdkU+v4AAS9n
	 smwL2KX2kn624R8N2SmHYcFjwLo54si3W0zzbj4vbms8NOusohacy6vLGxXeYRoeWbkr0
	 7CmrowSG1rZxUDegzw9LdEhZeAYw1ISHyfSJRjIQn1s/cwEc8fUTaoHkDo2HQcpvT8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k6aQ8TBg;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26B6072A1E
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 14:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA26B6072A1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k6aQ8TBg
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so38442755e9.0
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794493198; x=1795097998; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
        b=k6aQ8TBgvOP81qK8evRjO1kfyLhq37qbBlEGMjRzMYGHxNtz+BFOCJGKr3+gPAtExr
         K/8DJI+sKVNzR00NgxC69t1PwfynRjIf2+oh7dllbH8FG5RM4/Q96vp1B5lHIzdLccgi
         CRZSBsLU4uwpzZSB319txOuHJU0WN6vU0SvJWx7YpHJb4mWmieOOpEa+umXiQTn53Hnr
         VaxSyoM7oO53jHzZ+godH1VkcH8yZ9j4nzV0BYSqVLHlPp1o+Fx+lIM9+iZL2bS+HN6s
         XRN/wlXmoHVPxj2nJd59UsEt2NthrFB2Ahzd9U2gVna7dWd38fraBnq6oZe2CJkw7o0e
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493198; x=1795097998;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
        b=t23FJqT36fh46ZjQ1ec7lDhwZxpbY1TZxxZFScPGPfRjQyqeGElUmTlUddPPEGaiM6
         S0tmUv+gqKRIDaVR+X8nmmCFoRZT/yFNGy+DuhHu2pYdnPKx5R1kNzkd9cBrPpFszXI0
         2hdX2+QalA4NsaI0A4+8VedrsT7VeF4L+YeyIphBW6fyvD9o7PLdd8RXCjDAaaD8/zG/
         yFEy+zhmpoN7KZx8FeeKFVpxKRm3DP2dlWZ76gSLctkt13xlV8CelePMgZ/Pe1BHkxBV
         1m9v7vzn5cOecrgOEQHSO6a3k4WmScSExZ37Te9Fzf9okhLR2pY+G7ZSdqLIB2v0/7VK
         9Hew==
X-Gm-Message-State: APuU4Z+IMv7LjX5pDr17Hq4cR1E7bQoVdJ5Ymge1Ftbagbgxfn3pKu1V
	lWtwJIdPkKCnzVVuLdjhWAaA2ey4oQsAe87y19k2klBm/kPC+B+soWzw9s15IG70WZc=
X-Gm-Gg: AYBFou3+cdzavr+fpMJ6S8vZmYoJqgggSw7af6FUCbIavp4IvXyv+scqBgzGY7UpoFV
	lI4+fQtuZdNl67ipXGBIPp/Z0oZizKyB3DNwm3PthZxn3YZ8lezId/WIHqQ8+JgyycTyZmVbHwC
	LSyTbBykSiwFmjihVKUHbHkNuOxTb66AvSE3D+xaVVmoAaAWzC5S2j0+rI0t8qrZd9R871pljut
	Yi49c93Oz0QAZzQ1YeWrikKskhESh6BtF4kyOyTNEa++3L20SE0MJZEb8GazuYXzma+oDPJYACa
	uqfc0qxlHJi0jM0pRJmnf02Ksmp/mXmX9y9ry5D9IKo07ayJbmO8TnHeZMoE4PsYYI68u4S2EtV
	6yg4uU5NJmSrkLtD0hfyavCrcQMIUUR5B4sj5oEGHEJ4BH8IOItU3eLQsm0OwoUKXR/qqiKHN83
	pNFPi9Z97UTiqEoucA45zZaB3kE96jBJxn/geiK7R28k8/mfHTY2Gusi5ybfTA93xlwTQr3h7DL
	bhS6isH9UFEmkEZHH48nO7je/4bKVDbQDI4DPPtP/sxIBwQVKqRVI8GWFF+jcPIhfue07/hvvAX
	kQzgtjFQMoRSw5dJPtfvQin+MPg668TDM/jzfjh+qJE=
X-Received: by 2002:a05:600c:4f84:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ba0931ed6bmr104812575e9.4.1794493197930;
        Thu, 12 Nov 2026 06:19:57 -0800 (PST)
Received: from [192.168.0.167] ([109.78.26.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29d24dsm75906065e9.11.2026.11.12.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:19:57 -0800 (PST)
Message-ID: <a35530a0-3a4e-4975-8335-94898aa9abaa@linaro.org>
Date: Thu, 12 Nov 2026 14:19:55 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <quic_poza@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
 <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2026 14:04, Vikash Garodia wrote:
> 
> On 11/11/2026 5:32 PM, Bryan O'Donoghue wrote:
>> On 06/11/2026 17:14, Vikash Garodia wrote:
>>> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device 
>>> *dev, struct list_head *list)
>>>                   }
>>>                   type = iommu_resv_region_get_type(dev, &phys, iova, 
>>> length);
>>> +                if (type != IOMMU_RESV_DIRECT)
>>> +                    continue;
>>> +
>>
>> This change is not about requiring a reg though, which is why it 
>> should be a standalone patch with its own justifications.
>>
> 
> This is about reg, which determines the direct mapping, hence the code 
> is very much applicable to this patch. Please refer this code [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/ 
> tree/drivers/iommu/of_iommu.c#n223
But this change is not about requiring a reg. It's about not reserving 
when reg and IOVA don't match.

So reading a patch entitled "Require reg for iommu-addresses" doesn't 
actually transmit the information of what this second change does.

Which is why that change should have its own patch.

Require reg != don't reserve reg + non-matching IOVA.

A reasonable reviewer might ask "why is a mismatch dropped instead of 
reserved" - which is the question I ask myself as I read and IMO isn't 
answered - which is why I've asked for a patch which reasons that out.

It may be that conjoining iommu-addresses/reg and !reserving mismatch 
are in fact the same thing but I don't think that jumps out of the code 
as you read it and I doubt adding to this commit log would make it much 
clearer because it seems like two changes in one patch.

It would be something like "require a reg and don't reserve on mismatch"

The "and" part is the part I'm flagging as likely deserving its own 
patch which explains what/why but "require reg" ain't it.

---
bod
