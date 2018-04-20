From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: fix unused-variable warning
Date: Fri, 20 Apr 2018 11:47:14 +0200
Message-ID: <20180420094714.kjir26edq34i6ktq@linutronix.de>
References: <20180420092836.12219-1-tobias.regnery@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180420092836.12219-1-tobias.regnery-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tobias Regnery <tobias.regnery-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gMjAxOC0wNC0yMCAxMToyODozNiBbKzAyMDBdLCBUb2JpYXMgUmVnbmVyeSB3cm90ZToKPiBU
aGUgaW9tbXVfdGFibGVfbG9jayBpcyBvbmx5IHVzZWQgYnkgY29kZSBpbnNpZGUgYW4gaWZkZWYg
Q09ORklHX0lSUV9SRU1BUAo+IGJsb2NrLiBUaGlzIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgd2Fy
bmluZyB3aXRoIENPTkZJR19JUlFfUkVNQVA9bjoKPiAKPiBhbWRfaW9tbXUuYzo4NjoyNDogd2Fy
bmluZzogJ2lvbW11X3RhYmxlX2xvY2snIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC12
YXJpYWJsZV0KPiAKPiBHdWFyZCB0aGUgc3BpbmxvY2sgZGVmaW5pdGlvbiB3aXRoIHRoZSBzYW1l
IGlmZGVmLgo+IAo+IEZpeGVzOiBlYTYxNjZmNGI4M2U5ICgiaW9tbXUvYW1kOiBTcGxpdCBpcnFf
bG9va3VwX3RhYmxlIG91dCBvZiB0aGUgYW1kX2lvbW11X2RldnRhYmxlX2xvY2siKQo+IFNpZ25l
ZC1vZmYtYnk6IFRvYmlhcyBSZWduZXJ5IDx0b2JpYXMucmVnbmVyeUBnbWFpbC5jb20+CgpUaGFu
ayB5b3UgZm9yIHNwb3R0aW5nIHRoaXMsIEkgYW0gd2FpdGluZyBmb3IgSsO2cmcgdG8gcGljayB1
cCB0aGlzCmluc3RlYWQ6CiAgaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzIwMTgwNDA0MTA1NzEz
LjYzMzk4My0xLWFybmRAYXJuZGIuZGUKClNlYmFzdGlhbgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
