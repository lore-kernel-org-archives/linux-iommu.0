From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 10:19:54 -0700
Message-ID: <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417170918.GA68678@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com, Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de, keescook@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, tyhicks@canonical.com, David Woodhouse <dwmw@amazon.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, jcm@redhat.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, iommu <iommu@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>, Khalid Aziz <khalid@gonehiking.o>
List-Id: iommu@lists.linux-foundation.org

> On Apr 17, 2019, at 10:09 AM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
>=20
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
>=20
>>> I.e. the original motivation of the XPFO patches was to prevent =
execution=20
>>> of direct kernel mappings. Is this motivation still present if those=20=

>>> mappings are non-executable?
>>>=20
>>> (Sorry if this has been asked and answered in previous discussions.)
>>=20
>> Hi Ingo,
>>=20
>> That is a good question. Because of the cost of XPFO, we have to be =
very
>> sure we need this protection. The paper from Vasileios, Michalis and
>> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
>> and 6.2.
>=20
> So it would be nice if you could generally summarize external =
arguments=20
> when defending a patchset, instead of me having to dig through a PDF=20=

> which not only causes me to spend time that you probably already spent=20=

> reading that PDF, but I might also interpret it incorrectly. ;-)
>=20
> The PDF you cited says this:
>=20
>  "Unfortunately, as shown in Table 1, the W^X prop-erty is not =
enforced=20
>   in many platforms, including x86-64.  In our example, the content of=20=

>   user address 0xBEEF000 is also accessible through kernel address=20
>   0xFFFF87FF9F080000 as plain, executable code."
>=20
> Is this actually true of modern x86-64 kernels? We've locked down W^X=20=

> protections in general.

As I was curious, I looked at the paper. Here is a quote from it:

"In x86-64, however, the permissions of physmap are not in sane state.
Kernels up to v3.8.13 violate the W^X property by mapping the entire =
region
as =E2=80=9Creadable, writeable, and executable=E2=80=9D (RWX)=E2=80=94onl=
y very recent kernels
(=E2=89=A5v3.9) use the more conservative RW mapping.=E2=80=9D
