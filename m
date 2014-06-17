From: Ilya Lesokhin <ilya.lesokhin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: What devices are using ATS/PRI?
Date: Tue, 17 Jun 2014 16:10:07 +0300
Message-ID: <CAEPKs0f7NWVfrD5Gn3cRRfKbcrp3CtWZHvObwkDXErFe8ChbPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8337726761831329741=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: joerg.roedel-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============8337726761831329741==
Content-Type: multipart/alternative; boundary=047d7bd75b66e6ba2704fc07dc37

--047d7bd75b66e6ba2704fc07dc37
Content-Type: text/plain; charset=UTF-8

Hi,
I'm doing research about support for I/O page faults and I'm trying to find
out what devices are using it today.

I've notice that the AMD IOMMUv2 driver has support for I/O page faults.
However I'm a bit confused as to how it relates to ATS/PRI.

I've gotten the impression that the code is used by AMD GPUs to implement
HSA.
If I understand correctly HSA is implemented with integrated GPUs. I would
assume such GPUs wouldn't use PCIe to access memory, is that indeed the
case?

Do those GPUs use PRI to generate page faults anyway?

Thanks,
Ilya

--047d7bd75b66e6ba2704fc07dc37
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>I&#39;m doing research about support for I/O page f=
aults and I&#39;m trying to find out what devices are using it today.<br><b=
r>I&#39;ve notice that the AMD IOMMUv2 driver has support for I/O page faul=
ts. However I&#39;m a bit confused as to how it relates to ATS/PRI.<br>
<br>I&#39;ve gotten the impression that the code is used by AMD GPUs to imp=
lement HSA. <br>If I understand correctly HSA is implemented with integrate=
d GPUs. I would assume such GPUs wouldn&#39;t use PCIe to access memory, is=
 that indeed the case? <br>
<br>Do those GPUs use PRI to generate page faults anyway?<br><br>Thanks,<br=
>Ilya<br></div>

--047d7bd75b66e6ba2704fc07dc37--

--===============8337726761831329741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8337726761831329741==--
