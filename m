From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 22:33:45 +0200
Message-ID: <ecfb6f20-6f74-3d46-b3fb-696d36ab4008@redhat.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
	<CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
	<20170505112706.7785948c@t450s.home>
	<CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
	<545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
	<CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
	<5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com>
	<20170628130855.76c2b700@w520.home>
	<BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
	<BN6PR12MB13481A39CD3EA714754FEE49E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
	<CAEk7i1-Ar0ES8ekmSGiRrrWzTz8gFb2RDTW6KsbuNdDubVerww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAEk7i1-Ar0ES8ekmSGiRrrWzTz8gFb2RDTW6KsbuNdDubVerww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Graham Neville <grahamneville-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 28/06/2017 21:52, Graham Neville wrote:
> Although not related to graphics card performance, there is definitely
> another issue with regards to running KVM nested L2 guests when npt=1.
> 
> Thought I'd mention this in case it helps with identifying performance
> issues with NPT.
> 
> I'm unable to start any L2 guests with KVM acceleration (--enable-kvm).
> As soon as it attempts to bring up the L2 guest the L1 host crashes, L0
> host remains online. Nothing is printed in either L1 or L0's dmesg.
> 
> My L0 is running Arch with 4.11.0-rc6, with qemu 2.8.0. I've tried
> different L1 hosts (Ubuntu,Arch) and different kernels right to 4.12-rc5
> kernel, along with different qemu versions.
> 
> This used to work fine with my Intel i7-4770s setup.
> 
> With npt=0, L2 guests can start but performance is dier.

Nested AMD needs some care.  It's known, but time has been lacking...

Paolo
