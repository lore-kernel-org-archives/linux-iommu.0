Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4028E5EE
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716972; cv=none; b=KdtxXR40mcEKk6nG5dqPM+uywcRsVkkiecH72UWB69KyVYCcSV7A/hASbkNia88S1gyYqaAqtRT0zKVujZdoWuJkEa+hNhxVzyyXjc20yzZiu4u0oLfNUozEb2JX+yMwz3QGZosafKsGvEa6RohSyFs1tdwFxXMcjYSujmLUifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716972; c=relaxed/simple;
	bh=ecxh0DIByMnHf6ygrYZHPedHniG1Gc17UjqLlCDNNks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5ksRkh6yfWJCqtSvC6NBENQXsKzWiE0tH8zFQy4/uTBbM0ExkaxGu5xenB3uuxuwKBjDpz+KrJ5Ar9OnNI5y/Lkk8Cw0B7wZHsdBldnpT8fkpzCxmY4IMbR50InnbMAW59LpRzGGt6U4FMmS+rwx/fkfVD8Gqc2CUBjp4yndtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huCG0Owu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huCG0Owu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744716969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lXumDY4xCMKyDj7D8VQa+feWOdO7T/uIrMyU2wfkHqQ=;
	b=huCG0Owuxu1rsuWNK336525M3QZbkfkE4QFWYrJ+2auqXZF0xcHP3UXrtDrHUcrKiGnB5T
	U8hBeOMMaS0frz9vK2Ev010xMJroJBatVGi69TWfJcKzuMkeLpnJkSKJH9SnOwQP4d1wfN
	xNEHmK1lNavhd2+mL0B2c9aVxAr/al0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-qXKsQeKbPYaJlfrxkMfTSw-1; Tue, 15 Apr 2025 07:36:06 -0400
X-MC-Unique: qXKsQeKbPYaJlfrxkMfTSw-1
X-Mimecast-MFC-AGG-ID: qXKsQeKbPYaJlfrxkMfTSw_1744716966
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf446681cso35193875e9.1
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744716965; x=1745321765;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXumDY4xCMKyDj7D8VQa+feWOdO7T/uIrMyU2wfkHqQ=;
        b=ojqf8UzWINqJh2/E9ZrM8gmlV8RcKmeeavjAS12JI0KTIM+PvA+O21xi4bvUWbFnXp
         f8CU+VY/GGPqL6ys8HIVG7CBkvFw38WzN8WT/4kMnXYfF+Kz1/0v/TyJfnVeOnZwVCNG
         UysayLVPL/TY5WQRPSu4FVMi0521CVtEqbcg01v0E4OV+jnppuY6TXynrflgDuzPxDpJ
         jo1XPK2eNUXXkPW1wGTW/2TAVBlufydnyKPtcH97L1QX1XTXfzrfWh9Dy+J+8zEtJz1y
         h7ABdEUuCuJBixW87WL7GH0nbijqDmH4YjG/H8IpPYCFR58N2JKSH16FVlXb1GLcDEnk
         oVSw==
X-Forwarded-Encrypted: i=1; AJvYcCUWwfndEQDMM14LRLQ3XxbbE1Mmu8W0+MYbeaytL+LFc9oLypy1pRJkWqwpeXuKayCAzADZaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCA8DnB+dxJQsxLQ13h2ZNV/uzzZVnWQWOi6divxhMg8lLRDIZ
	AY9e9IO10iqXTl5PiSCpHlFRsqUs9qfvSUNC0U4PFl3Qa6C6GUK56wka0IkJ4kDMXBY+DUCDFuC
	eVX4o4Ih91BCHZiPm1GLJgKKHRXmvjypzYC2v/U+5c1ZvkDJLk3kt
X-Gm-Gg: ASbGnctuMFckpxFyL+sYWrN6qcGaiRP+DajW80iMsiIX5eDW41lCMP81M1xmmk6w9TQ
	uwL6trrDCs/6ehC81max2Y8E/pAI/NgpCWZeFBH7b7DlZUmbKpy1/GbSecJ4sq5X5o/KfVC0we5
	TMEx46rhP43es2UmVaFyPM9DQp1LLx38HiyUqf54onkErMrSC/AUtQQ8CGwkDJzfmWwRbi3hHai
	2wz391Fj0kDQ25u1Q5ck8x9gWYsaZOM6HetbOEXmvgLap3viRB53u6s3rcfHCupO8haDQhlhhZP
	wcVNqaHdjodhbd9R
X-Received: by 2002:a05:600c:1e18:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-43f3a9aad9dmr116295635e9.25.1744716965527;
        Tue, 15 Apr 2025 04:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkTE6bgF5Rb9zhuxM/+FO7GOrmCPiOvR+9BRMeJxMAeIAq7zucZTzAlJuAYb8wTmelGeqiw==
X-Received: by 2002:a05:600c:1e18:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-43f3a9aad9dmr116295435e9.25.1744716965159;
        Tue, 15 Apr 2025 04:36:05 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f2338dc13sm213154095e9.3.2025.04.15.04.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:36:04 -0700 (PDT)
Message-ID: <e6606b04-6154-4823-80a3-dc47392dcc59@redhat.com>
Date: Tue, 15 Apr 2025 13:36:02 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/67] KVM: x86: Reset IRTE to host control if *new* route
 isn't postable
To: Sean Christopherson <seanjc@google.com>,
 Sairaj Kodilkar <sarunkod@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, David Matlack
 <dmatlack@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Naveen N Rao <naveen.rao@amd.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-3-seanjc@google.com>
 <ad53c9fe-a874-4554-bce5-a5bcfefe627a@amd.com> <Z_kkTlpqEEWRAk3g@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <Z_kkTlpqEEWRAk3g@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IQ5jcYs098B-Hf3DAXIKRpVTHuG-R-U8zmfbL5I6GMs_1744716966
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/25 16:16, Sean Christopherson wrote:
> On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
>> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
>>> @@ -991,7 +967,36 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
>>>    		}
>>>    	}
>>> -	ret = 0;
>>> +	if (enable_remapped_mode) {
>>> +		/* Use legacy mode in IRTE */
>>> +		struct amd_iommu_pi_data pi;
>>> +
>>> +		/**
>>> +		 * Here, pi is used to:
>>> +		 * - Tell IOMMU to use legacy mode for this interrupt.
>>> +		 * - Retrieve ga_tag of prior interrupt remapping data.
>>> +		 */
>>> +		pi.prev_ga_tag = 0;
>>> +		pi.is_guest_mode = false;
>>> +		ret = irq_set_vcpu_affinity(host_irq, &pi);
>>> +
>>> +		/**
>>> +		 * Check if the posted interrupt was previously
>>> +		 * setup with the guest_mode by checking if the ga_tag
>>> +		 * was cached. If so, we need to clean up the per-vcpu
>>> +		 * ir_list.
>>> +		 */
>>> +		if (!ret && pi.prev_ga_tag) {
>>> +			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
>>> +			struct kvm_vcpu *vcpu;
>>> +
>>> +			vcpu = kvm_get_vcpu_by_id(kvm, id);
>>> +			if (vcpu)
>>> +				svm_ir_list_del(to_svm(vcpu), &pi);
>>> +		}
>>> +	} else {
>>> +		ret = 0;
>>> +	}
>>
>> Hi Sean,
>> I think you can remove this else and "ret = 0". Because Code will come to
>> this point when irq_set_vcpu_affinity() is successful, ensuring that ret is
>> 0.
> 
> Ah, nice, because of this:
> 
> 		if (ret < 0) {
> 			pr_err("%s: failed to update PI IRTE\n", __func__);
> 			goto out;
> 		}
> 
> However, looking at this again, I'm very tempted to simply leave the "ret = 0;"
> that's already there so as to minimize the change.  It'll get cleaned up later on
> no matter what, so safety for LTS kernels is the driving factor as of this patch.
> 
> Paolo, any preference?

If you mean squashing this in:

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ef08356fdb1c..8e09f6ae98fd 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -967,6 +967,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
                 }
         }
  
+       ret = 0;
         if (enable_remapped_mode) {
                 /* Use legacy mode in IRTE */
                 struct amd_iommu_pi_data pi;
@@ -994,8 +995,6 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
                         if (vcpu)
                                 svm_ir_list_del(to_svm(vcpu), &pi);
                 }
-       } else {
-               ret = 0;
         }
  out:
         srcu_read_unlock(&kvm->irq_srcu, idx);

to undo the moving of "ret = 0", that's a good idea yes.

Paolo

