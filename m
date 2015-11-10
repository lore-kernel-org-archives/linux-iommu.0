From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 4/4] iommu/vt-d: Do access checks before calling
 handle_mm_fault()
Date: Tue, 10 Nov 2015 15:52:26 +0100
Message-ID: <20151110145226.GK2255@suse.de>
References: <1447162006-20672-1-git-send-email-joro@8bytes.org>
 <1447162006-20672-5-git-send-email-joro@8bytes.org>
 <1447166756.81031.66.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447166756.81031.66.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Oded Gabbay <oded.gabbay@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 10, 2015 at 02:45:56PM +0000, David Woodhouse wrote:
> On Tue, 2015-11-10 at 14:26 +0100, Joerg Roedel wrote:
> > +static bool access_error(struct vm_area_struct *vma, struct
> > page_req_dsc *req)
> > +{
> > +	return !((req->rd_req=C2=A0=C2=A0&& (vma->vm_flags & VM_READ))=C2=
=A0=C2=A0||
> > +		=C2=A0(req->wr_req=C2=A0=C2=A0&& (vma->vm_flags & VM_WRITE)) ||
> > +		=C2=A0(req->exe_req && (vma->vm_flags & VM_EXEC)));
> > +}
> > +
>=20
> This is a TLB fill request from the device =E2=80=94 can it not be as=
king for
> *all* of read, write and exec privs? And you allow it to succeed if a=
ny
> *one* of the permissions that it asks for is available?
>=20
> Even if we don't see read+write in the same request, the VT-d spec do=
es
> seem quite clear that we *will* see read+exec (=C2=A77.5.1.1 p7-17 of=
 v2.3:
>=20
> =E2=80=A2 Execute Requested: If the PASID Present, Read Requested and=
 Execute
> =C2=A0 Requested fields are all 1, the request-with-PASID that encoun=
tered=C2=A0
> =C2=A0 the recoverable fault that resulted in this page request, requ=
ires=C2=A0
> =C2=A0 execute access to the page.

Okay, thanks for the clarification. The code above assumes that only on=
e
of RWX is set. I'll update the patch to correctly check when multiple
bits are set.


	Joerg
