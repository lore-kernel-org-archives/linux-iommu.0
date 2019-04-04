From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [RFC PATCH v9 02/13] x86: always set IF before oopsing from page
	fault
Date: Thu, 4 Apr 2019 11:11:26 -0600
Message-ID: <8876301F-C720-4DFD-8D01-F9C526E21A10@amacapital.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<e6c57f675e5b53d4de266412aa526b7660c47918.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXvwuwkVSJ+S5s7wTBkNNj3fRVxpx9BvsXWrT=3ZdRnCw@mail.gmail.com>
	<20190404013956.GA3365@cisco>
	<CALCETrVp37Xo3EMHkeedP1zxUMf9og=mceBa8c55e1F4G1DRSQ@mail.gmail.com>
	<20190404154727.GA14030@cisco>
	<alpine.DEB.2.21.1904041822320.1802@nanos.tec.linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.21.1904041822320.1802-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Woodhouse, David" <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joao Martins <joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hp>
List-Id: iommu@lists.linux-foundation.org

Cj4gT24gQXByIDQsIDIwMTksIGF0IDEwOjI4IEFNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6Cj4gCj4+IE9uIFRodSwgNCBBcHIgMjAxOSwgVHljaG8gQW5kZXJz
ZW4gd3JvdGU6Cj4+ICAgIGxlYXEgICAgLVBUUkVHU19TSVpFKCVyYXgpLCAlcnNwCj4+ICAgIFVO
V0lORF9ISU5UX0ZVTkMgc3Bfb2Zmc2V0PVBUUkVHU19TSVpFCj4+IAo+PiArICAgIC8qCj4+ICsg
ICAgICogSWYgd2Ugb29wc2VkIGluIGFuIGludGVycnVwdCBoYW5kbGVyLCBpbnRlcnJ1cHRzIG1h
eSBiZSBvZmYuIExldCdzIHR1cm4KPj4gKyAgICAgKiB0aGVtIGJhY2sgb24gYmVmb3JlIGdvaW5n
IGJhY2sgdG8gIm5vcm1hbCIgY29kZS4KPj4gKyAgICAgKi8KPj4gKyAgICBzdGkKPiAKPiBUaGF0
IGJyZWFrcyB0aGUgcGFyYXZpcnQgbXVjayBhbmQgdHJhY2luZy9sb2NrZGVwLgo+IAo+IEVOQUJM
RV9JTlRFUlJVUFRTKCkgaXMgd2hhdCB5b3Ugd2FudCBwbHVzIFRSQUNFX0lSUV9PTiB0byBrZWVw
IHRoZSB0cmFjZXIKPiBhbmQgbG9ja2RlcCBoYXBweS4KPiAKPiAKCknigJltIHN1cmUgd2XigJls
bCBmaW5kIHNvbWUgb3RoZXIgdGhpbmcgd2UgZm9yZ290IHRvIHJlc2V0IGV2ZW50dWFsbHksIHNv
IGxldOKAmXMgZG8gdGhpcyBpbiBDLiAgQ2hhbmdlIHRoZSBjYWxsIGRvX2V4aXQgdG8gY2FsbCBf
X2ZpbmlzaF9yZXdpbmRfc3RhY2tfZG9fZXhpdCBhbmQgYWRkIHRoZSBsYXR0ZXIgYXMgYSBDIGZ1
bmN0aW9uIHRoYXQgZG9lcyBsb2NhbF9pcnFfZW5hYmxlKCkgYW5kIGRvX2V4aXQoKS4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
