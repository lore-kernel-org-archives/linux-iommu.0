From: Nick Sarnie <commendsarnex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 21:54:07 -0400
Message-ID: <CAOcCaLbs8UPNUDus7hQoVez0gu_7CJCT1sZArdDjiqDGXAT44Q@mail.gmail.com>
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
	<ecfb6f20-6f74-3d46-b3fb-696d36ab4008@redhat.com>
	<CAOcCaLao_Y-8KP60baoSehtCu7C5CVnuuZNEom-zi54Fa2h+sQ@mail.gmail.com>
	<CAAq2Xdpu_rv7FgVfGCv-nYttGzH6hZujqdYvcf4qgXetkOGLzw@mail.gmail.com>
	<CAAq2XdppNcKcmbJhPQ9WfTowKSmp76jhDa9JHM1rc92Enx=1Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAq2XdppNcKcmbJhPQ9WfTowKSmp76jhDa9JHM1rc92Enx=1Zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thiago Padilha <tpadilha84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 28, 2017 at 9:50 PM, Thiago Padilha <tpadilha84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Some more data from 3DMark benchmarks:
>
> Time Spy(DirectX 12):
> - Graphics test 1:
>   - npt=0: 37.65 FPS
>   - npt=1: 24.22 FPS (36% drop)
> - Graphics test 2:
>   - npt=0: 33.05 FPS
>   - npt=1: 29.65 FPS (10% drop)
> - CPU test:
>   - npt=0: 17.35 FPS
>   - npt=1: 12.03 FPS (31% drop)
>
> Fire Strike(DirectX 11):
> - Graphics test 1:
>   - npt=0: 80.56 FPS
>   - npt=1: 41.89 FPS (49% drop)
> - Graphics test 2:
>   - npt=0: 70.64 FPS
>   - npt=1: 60.75 FPS (14% drop)
> - Physics test:
>   - npt=0: 50.14 FPS
>   - npt=1: 5.78 FPS (89% drop)
> - Combined test:
>   - npt=0: 32.83 FPS
>   - npt=1: 17.70 FPS (47% drop)
>
> Sky Diver(DirectX 11):
> - Graphics test 1:
>   - npt=0: 248.81 FPS
>   - npt=1: 173.63 FPS (31% drop)
> - Graphics test 2:
>   - npt=0: 250.49 FPS
>   - npt=1: 124.84 FPS (51% drop)
> - Physics test:
>   - 8 threads:
>     - npt=0: 140.93 FPS
>     - npt=1: 119.08 FPS (15% drop)
>   - 24 threads:
>     - npt=0: 110.22 FPS
>     - npt=1: 74.55 FPS (33% drop)
>   - 48 threads:
>     - npt=1: 71.56 FPS
>     - npt=1: 45.93 FPS (36% drop)
>   - 96 threads:
>     - npt=0: 41.04 FPS
>     - npt=1: 24.81 FPS (40% drop)
> - Combined test:
>   - npt=0: 75.65 FPS
>   - npt=1: 50.45 FPS (33% drop)

Hi Thiago,

Thanks for the data, I'm sure it will be useful. Sorry, I should have
noted that I've only tested a few games/benchmarks and never any
non-intensive loads.

Sarnex
