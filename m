From: kumara rathnavel <kumara.bsd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Using Contig alloc finction
Date: Sun, 13 Dec 2015 18:46:17 +0530
Message-ID: <CA+NzLaOYuVcbwXFT0_sLP0-59xAVq8NF6jcJyD4KHe+V96GAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0481147111498675695=="
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
List-Id: iommu@lists.linux-foundation.org

--===============0481147111498675695==
Content-Type: multipart/alternative; boundary=047d7ba97d689cfc5d0526c75c0e

--047d7ba97d689cfc5d0526c75c0e
Content-Type: text/plain; charset=UTF-8

Hello Everyone,

I need a around 2GB of physically contiguous memory in Linux.  I am using
vanilla kernel 4.3 in Fedroa22. I am aware about the function
alloc_contig_range and that function should be used through DMA. In DMA
what is the exact API to be used and I have enabled CONFIG_CMA and
CONFIG_CMA_DMA . In kernel coomand line parameters what is the exact stuff
to be given. The documentation is not proper for the kernel parameters in
 the documentation provided in the source code. Is there any other way to
allocate large chunk of memory that is contiguous.

Thanking You,
Kumar.

--047d7ba97d689cfc5d0526c75c0e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Everyone,<div><br></div><div>I need a around 2GB of =
physically contiguous memory in Linux.=C2=A0 I am using vanilla kernel 4.3 =
in Fedroa22. I am aware about the function alloc_contig_range and that func=
tion should be used through DMA. In DMA what is the exact API to be used an=
d I have enabled CONFIG_CMA and CONFIG_CMA_DMA . In kernel coomand line par=
ameters what is the exact stuff to be given. The documentation is not prope=
r for the kernel parameters in =C2=A0the documentation provided in the sour=
ce code. Is there any other way to=C2=A0</div><div>allocate large chunk of =
memory that is contiguous.</div><div><br></div><div>Thanking You,</div><div=
>Kumar.=C2=A0</div></div>

--047d7ba97d689cfc5d0526c75c0e--

--===============0481147111498675695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0481147111498675695==--
