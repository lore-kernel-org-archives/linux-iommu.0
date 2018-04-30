From: Jintack Lim <jintack@cs.columbia.edu>
Subject: Re: How to check if Vt-d is capable of
 posted-interrupt?
Date: Mon, 30 Apr 2018 13:44:23 -0400
Message-ID: <CAHyh4xjzi5CK8+OJPpnr+F2ABpy5Jbbo1S4YR5ATi62LMRn+Pw@mail.gmail.com>
References: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
To: iommu@lists.linux-foundation.org
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, KVM General <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Add iommu mailing list since this question might be more related to iommu.

On Mon, Apr 30, 2018 at 10:11 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
> Hi,
>
> I wonder how to check if Vt-d is capable of posted-interrupt? I'm
> using Intel E5-2630 v3.
>
> I was once told that APICv and posted-interrupt capability always come
> together. But it seems like my cpu support APICv
> (/sys/module/kvm_intel/parameters/enable_apicv is Y), but
> posted-interrupt capability is only shipped with the next generation
> of the cpu (E5-2600 v4, which is Broadwell).
>
> What would be an easy way to check this?
>
> Thanks,
> Jintack
