From: Nick Sarnie <commendsarnex@gmail.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 18:34:57 -0400
Message-ID: <CAOcCaLao_Y-8KP60baoSehtCu7C5CVnuuZNEom-zi54Fa2h+sQ@mail.gmail.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
 <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
 <20170505112706.7785948c@t450s.home> <CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
 <545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com> <CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
 <5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com> <20170628130855.76c2b700@w520.home>
 <BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <BN6PR12MB13481A39CD3EA714754FEE49E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <CAEk7i1-Ar0ES8ekmSGiRrrWzTz8gFb2RDTW6KsbuNdDubVerww@mail.gmail.com> <ecfb6f20-6f74-3d46-b3fb-696d36ab4008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ecfb6f20-6f74-3d46-b3fb-696d36ab4008@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Graham Neville <grahamneville@gmail.com>, "Bridgman, John" <John.Bridgman@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Matthias Ehrenfeuchter <efeu@markju.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 28, 2017 at 4:33 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 28/06/2017 21:52, Graham Neville wrote:
>> Although not related to graphics card performance, there is definitely
>> another issue with regards to running KVM nested L2 guests when npt=1.
>>
>> Thought I'd mention this in case it helps with identifying performance
>> issues with NPT.
>>
>> I'm unable to start any L2 guests with KVM acceleration (--enable-kvm).
>> As soon as it attempts to bring up the L2 guest the L1 host crashes, L0
>> host remains online. Nothing is printed in either L1 or L0's dmesg.
>>
>> My L0 is running Arch with 4.11.0-rc6, with qemu 2.8.0. I've tried
>> different L1 hosts (Ubuntu,Arch) and different kernels right to 4.12-rc5
>> kernel, along with different qemu versions.
>>
>> This used to work fine with my Intel i7-4770s setup.
>>
>> With npt=0, L2 guests can start but performance is dier.
>
> Nested AMD needs some care.  It's known, but time has been lacking...
>
> Paolo
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

Hi Suravee,

Thanks a lot for helping. Torcs does not appear graphically demanding
on modern hardware, so this issue may not be easily noticeable. I was
able to easily reproduce the problem using the Unigine Heaven
benchmark, but I'm sure anything moderately graphically demanding
would show a performance loss with NPT enabled. As an example, when I
tested this with Fedora on my RX480, I got around 30-35 FPS with NPT
on and around 55-60 with NPT off.

Let me know if you need any more information or have any questions.

(no problem John, thanks a lot for taking interest in this)

Thanks again,
Sarnex
