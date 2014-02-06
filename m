From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: IOMMU DMA-mapping API for arm64 ?
Date: Thu, 6 Feb 2014 10:51:53 +0530
Message-ID: <CAD15agbDSH4dQ8aDsW7hXZE_6Bfmpc1WrqhH2Bx0Fuy-eQUfbQ@mail.gmail.com>
References: <CAD15agaA9c1+0svk_d97ZEcaOg6x_PGcbKVHM9dWAZ_t1T8FXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5112658453257806902=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAD15agaA9c1+0svk_d97ZEcaOg6x_PGcbKVHM9dWAZ_t1T8FXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============5112658453257806902==
Content-Type: multipart/alternative; boundary=001a1133ec9621a5d304f1b60dfb

--001a1133ec9621a5d304f1b60dfb
Content-Type: text/plain; charset=ISO-8859-1

"Sorry if this mail has come twice in your mailbox"

Hi everyone,

I tried looking for IOMMU support in ARM64 but what I was able to see is
only swiotlb is currently supported.

Based on my understanding for IOMMU support, we need DMA-MAPPING API to
have IOMMU ops field, similar to what is present in arm32.
I could see the iommu field added in dev_archdata in below mentioned patch
(arch/arm64/include/asm/device.h), but there is no ops field in
arch/arm64/mm/dma-mapping.c ?

I also saw one mail discussion between you guys on what is the best place
for adding iommu support in ARM64, but couldn't see any followed up patches
for the same.

Please tell us the current status/updates on the same. Your feedback will
be greatly appreciated.


commit 73150c983ac1f9b7653cfd3823b1ad4a44aad3bf
Author: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Date:   Mon Jun 10 19:34:42 2013 +0100

    arm64: device: add iommu pointer to device archdata

    When using an IOMMU for device mappings, it is necessary to keep a
    pointer between the device and the IOMMU to which it is attached in
    order to obtain the correct IOMMU when attaching the device to a domain.

    This patch adds an iommu pointer to the dev_archdata structure, in a
    similar manner to other architectures (ARM, PowerPC, x86, ...).

    Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
    Signed-off-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>


Thanks
Ritesh

--001a1133ec9621a5d304f1b60dfb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">&quot;Sorry if this mail ha=
s come twice in your mailbox&quot; <br></div><div class=3D"gmail_quote"><br=
><div dir=3D"ltr"><div><div><div><div>Hi everyone, <br><br></div>I tried lo=
oking for IOMMU support in ARM64 but what I was able to see is only swiotlb=
 is currently supported. <br>
<br></div>Based on my understanding for IOMMU support, we need DMA-MAPPING =
API to have IOMMU ops field, similar to what is present in arm32. <br>

</div>I could see the iommu field added in dev_archdata in below mentioned =
patch (arch/arm64/include/asm/device.h), but there is no ops field in arch/=
arm64/mm/dma-mapping.c ? <br><br></div><div>I also saw one mail discussion =
between you guys on what is the best place for adding iommu support in ARM6=
4, but couldn&#39;t see any followed up patches for the same. <br>


<br></div><div>Please tell us the current status/updates on the same. Your =
feedback will be greatly appreciated. <br></div><div><div><div><div><div><b=
r><br>commit 73150c983ac1f9b7653cfd3823b1ad4a44aad3bf<br>Author: Will Deaco=
n &lt;<a href=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">will.deacon@=
arm.com</a>&gt;<br>


Date:=A0=A0 Mon Jun 10 19:34:42 2013 +0100<br><br>=A0=A0=A0 arm64: device: =
add iommu pointer to device archdata<br><br>=A0=A0=A0 When using an IOMMU f=
or device mappings, it is necessary to keep a<br>=A0=A0=A0 pointer between =
the device and the IOMMU to which it is attached in<br>


=A0=A0=A0 order to obtain the correct IOMMU when attaching the device to a =
domain.<br><br>=A0=A0=A0 This patch adds an iommu pointer to the dev_archda=
ta structure, in a<br>=A0=A0=A0 similar manner to other architectures (ARM,=
 PowerPC, x86, ...).<br>


<br>=A0=A0=A0 Signed-off-by: Will Deacon &lt;<a href=3D"mailto:will.deacon@=
arm.com" target=3D"_blank">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&gt;<br>=A0=A0=A0 Signed-=
off-by: Catalin Marinas &lt;<a href=3D"mailto:catalin.marinas-5wv7dgnIgG8@public.gmane.org" targ=
et=3D"_blank">catalin.marinas-5wv7dgnIgG8@public.gmane.org</a>&gt;<br>


<br><br></div><div>Thanks <br><span class=3D"HOEnZb"><font color=3D"#888888=
">Ritesh <br></font></span></div></div></div></div></div></div>
</div><br></div>

--001a1133ec9621a5d304f1b60dfb--

--===============5112658453257806902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5112658453257806902==--
