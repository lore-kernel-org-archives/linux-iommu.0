From: Thiago Padilha <tpadilha84@gmail.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Sat, 1 Jul 2017 11:15:27 -0300
Message-ID: <CAAq2XdqHMNJ_R8diSHUatBw9p2-SH7v9us9StmP+obTOAc8-FQ@mail.gmail.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
 <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
 <20170505112706.7785948c@t450s.home> <CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
 <545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com> <CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
 <5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com> <20170628130855.76c2b700@w520.home>
 <BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <BN6PR12MB13481A39CD3EA714754FEE49E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <CAEk7i1-Ar0ES8ekmSGiRrrWzTz8gFb2RDTW6KsbuNdDubVerww@mail.gmail.com>
 <ecfb6f20-6f74-3d46-b3fb-696d36ab4008@redhat.com> <CAOcCaLao_Y-8KP60baoSehtCu7C5CVnuuZNEom-zi54Fa2h+sQ@mail.gmail.com>
 <CAAq2Xdpu_rv7FgVfGCv-nYttGzH6hZujqdYvcf4qgXetkOGLzw@mail.gmail.com>
 <CAAq2XdppNcKcmbJhPQ9WfTowKSmp76jhDa9JHM1rc92Enx=1Zg@mail.gmail.com> <CAOcCaLbs8UPNUDus7hQoVez0gu_7CJCT1sZArdDjiqDGXAT44Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAOcCaLbs8UPNUDus7hQoVez0gu_7CJCT1sZArdDjiqDGXAT44Q@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Nick Sarnie <commendsarnex@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Matthias Ehrenfeuchter <efeu@markju.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Bridgman, John" <John.Bridgman@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hi

Just wanted to add that I've also tested passthrough with Xen and my radeon
rx460(unfortunately Xen doesn't work with nvidia yet) and confirm that hardware
assisted paging seems to work flawless without affecting GPU performance.

An easy way to verify this is to run the following Passmark's PerformanceTest
benchmarks:

- CPU
- Memory
- 3d

and compare with the results on bare metal and with KVM when npt=1/npt=0. This
benchmark is ideal for reproducing the issue because the 3d performance impact
of the directx9/directx12 tests are significant(about 90% drop in FPS, as I've
mentioned in my previous post).

With Xen, I get the same CPU/Memory scores as KVM with npt=1,
and the same CPU/3d scores as with KVM with npt=0. Summary:

- npt=0 causes drop in Memory test score
- npt=1 causes drop in 3d performance

Xen doesn't suffer performance hit in any of the benchmarks(assuming
HAP enabled),
and is very close to bare metal in all benchmarks except for disk
benchmark. This
result(with Nick Sarnie previous result) suggests that the bug is
located in KVM.

Thiago.
