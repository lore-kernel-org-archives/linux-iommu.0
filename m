From: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Question on IOMMU indentity mapping for intel-iommu
Date: Mon, 26 Feb 2018 15:01:35 -0800
Message-ID: <CAKgT0UfgW23f6K-TbOP=6t=LPEH8e-6xphjZ7amC-Bvb3-S-GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

I am interested in adding a new memory mapping option that establishes
one identity-mapped region for all DMA_TO_DEVICE mappings and creates
a new dynamic mapping for any DMA_FROM_DEVICE and DMA_BIDIRECTIONAL
mappings. My thought is it should allow for a compromise between
security and performance (in the case of networking) in that many of
the server NICs drivers these days are running with mostly pinned or
resused paged for Rx. By using an identity mapping for the Tx packets
we should be able to significantly cut down on the IOMMU overhead for
the device. The other advantage if this works is that we could use
this to possibly do something like dirty page tracking in the case of
a emulated version of the IOMMU.

I was originally thinking I could get away with just reusing the
identity mapping code but it looks like that would end up merging
everything into one domain if I am understanding correctly. Do I have
that right?

Would I be correct in assuming that I will need to have a separate
domain per device, each domain containing the 1 TO_DEVICE identity
mapped region, and then whatever other mappings are needed to handle
the FROM and BIDIRECTIONAL mappings?

Thanks.

- Alex
