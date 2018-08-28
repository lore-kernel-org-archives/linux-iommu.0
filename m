From: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Subject: Re: new SBus related DMA warnings in 4.18+git
Date: Tue, 28 Aug 2018 13:30:50 +0300 (EEST)
Message-ID: <alpine.LRH.2.21.1808281330270.13945@math.ut.ee>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
	<20180828092915.GC12488@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180828092915.GC12488-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

PiBCYXNlZCBvbiB0aGUgb3RoZXIgdGhyZWFkIGhlcmUgaXMgYSBuZXcgYXR0ZW1wdDoKCiAgQ0Mg
ICAgICBhcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2VfNjQubwphcmNoL3NwYXJjL2tlcm5lbC9v
Zl9kZXZpY2VfNjQuYzogSW4gZnVuY3Rpb24goXNjYW5fb25lX2RldmljZaI6CmFyY2gvc3BhcmMv
a2VybmVsL29mX2RldmljZV82NC5jOjY3ODoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24goURNQV9CSVRfTUFTS6IgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVj
bGFyYXRpb25dCiAgb3AtPmRldi5jb2hlcmVudF9kbWFfbWFzayA9IERNQV9CSVRfTUFTSygzMik7
CiAgXgphcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2VfNjQuYzo2Nzk6MjQ6IGVycm9yOiChc3Ry
dWN0IHBsYXRmb3JtX2RldmljZaIgaGFzIG5vIG1lbWJlciBuYW1lZCChZG1hX21hc2uiCiAgb3At
PmRldi5kbWFfbWFzayA9ICZvcC0+ZG1hX21hc2s7CiAgICAgICAgICAgICAgICAgICAgICAgIF4K
YXJjaC9zcGFyYy9rZXJuZWwvb2ZfZGV2aWNlXzY0LmM6NjgwOjQ6IGVycm9yOiChc3RydWN0IHBs
YXRmb3JtX2RldmljZaIgaGFzIG5vIG1lbWJlciBuYW1lZCChZG1hX21hc2uiCiAgb3AtPmRtYV9t
YXNrID0gRE1BX0JJVF9NQVNLKDMyKTsKICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJl
YXRlZCBhcyBlcnJvcnMKc2NyaXB0cy9NYWtlZmlsZS5idWlsZDozMDc6IHJlY2lwZSBmb3IgdGFy
Z2V0ICdhcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2VfNjQubycgZmFpbGVkCgoKLS0gCk1lZWxp
cyBSb29zIChtcm9vc0BsaW51eC5lZSkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
