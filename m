From: Thiago Padilha <tpadilha84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 21:21:04 -0300
Message-ID: <CAAq2Xdpu_rv7FgVfGCv-nYttGzH6hZujqdYvcf4qgXetkOGLzw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOcCaLao_Y-8KP60baoSehtCu7C5CVnuuZNEom-zi54Fa2h+sQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nick Sarnie <commendsarnex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 28, 2017 at 7:34 PM, Nick Sarnie <commendsarnex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Suravee,
>
> Thanks a lot for helping. Torcs does not appear graphically demanding
> on modern hardware, so this issue may not be easily noticeable. I was
> able to easily reproduce the problem using the Unigine Heaven
> benchmark, but I'm sure anything moderately graphically demanding
> would show a performance loss with NPT enabled. As an example, when I
> tested this with Fedora on my RX480, I got around 30-35 FPS with NPT
> on and around 55-60 with NPT off.
>
> Let me know if you need any more information or have any questions.
>
> (no problem John, thanks a lot for taking interest in this)
>
> Thanks again,
> Sarnex

Hi

I don't think the FPS drop is proportional to how graphically demanding the
workload is. On the contrary, at first sight it would seem like the less
demanding a workload is, the bigger the FPS impact suffered, though as some
numbers I will show in a moment suggest, this is not always the case.

Unfortunately I haven't been able to find a pattern to what causes the most
impact in FPS except that the relative drop increases with higher FPS
values. Other
than that, it seems very specific to the workload/benchmark used.

Here's some data I've collected to help with the investigation. The system is
Ryzen 1700 (no overclock, 3ghz), GTX 1070, windows 10 guest.

I've used Unigine Heaven and Passmark's PerformanceTest 9.0.

First Heaven benchmark with ultra settings on 1920x1080:

- DirectX 11:
  - npt=0: 87.0 fps
  - npt=1: 78.4 fps (10% drop)
- DirectX 9:
  - npt=0: 100.0 fps
  - npt=1: 66.4 fps (33% drop)
- OpenGL:
  - npt=0: 82.5 fps
  - npt=1: 35.2 fps (58% drop)

Heaven Benchmark again, this time with low settings on 1280x720:

- DirectX 11:
  - npt=0: 182.5 fps
  - npt=1: 140.1 fps (25% drop)
- DirectX 9:
  - npt=0: 169.2 fps
  - npt=1: 74.1 fps (56% drop)
- OpenGL:
  - npt=0: 202.8 fps
  - npt=1: 45.0 fps (78% drop)

PerformanceTest 9.0 3d benchmark:

- DirectX 9:
  - npt=0: 157 fps
  - npt=1: 13 fps (92% drop)
- DirectX 10:
  - npt=0: 220 fps
  - npt=1: 212 fps (4% drop)
- DirectX 11:
  - npt=0: 234 fps
  - npt=1: 140 fps (40% drop)
- DirectX 12:
  - npt=0: 88 fps (scored 35 because of the penalized FPS of not being
able to run at 4k)
  - npt=1: 4.5 fps (scored 1, 95% drop)
- GPU Compute:
  - Mandel:
    - npt=0: ~= 2000 fps
    - npt=1: ~= 2000 fps
  - Bitonic Sort:
    - npt=0: ~= 153583696.0 elements/sec
    - npt=1: ~= 106233376.0 elements/sec (31% drop)
  - QJulia4D:
    - npt=0: ~= 1000 fps
    - npt=1: ~= 1000 fps
  - OpenCL:
    - npt=0: ~= 750 fps
    - npt=1: ~= 220 fps

As you can see, in some cases there's only about 5% drop(which could be within
the margin of error), while others the drop is as high as 95%. Some points of
interest:

- Passmark directx9 is not graphically demanding(runs at 1024x768, gtx 1070
  doesn't break a sweat) and suffers a 92% drop in FPS.
- Unigine directx11 on ultra is graphically demanding and suffers less than 10%
  drop in FPS.
- Passmark directx12 is graphically demanding and suffers 95% drop in FPS.
- The bitonic sort is not a graphical benchmark, it shows the results(avg number
  of sorted elements/sec) in a console window, yet it suffers 31% drop in
  performance.

I think it would take someone with experience in GPU programming, and with
knowledge of what each benchmark does, to find a pattern in these numbers.

Thiago
