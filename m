From: Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Subject: Re: PROBLEM: Deadlock in attach_device() in AMD IOMMU driver
Date: Wed, 6 May 2015 12:44:33 +0100
Message-ID: <5549FEA1.9080801@solarflare.com>
References: <55488C3D.50509@solarflare.com> <20150505144159.GI15736@8bytes.org>
	<5548D814.6020807@solarflare.com>
	<20150505153344.GR15736@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150505153344.GR15736-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kieran Mansley <kmansley-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/05/15 16:33, Joerg Roedel wrote:
> Okay, I'll have a look into the SLES12 kernel sources to check there.
> Can you reproduce this with a recent upstream kernel?

I've done some more tests this morning and can reproduce the problem on
a vanilla 4.0 kernel with a SLES12 userland, and also on a stock
installation of Ubuntu 14.10 with a 3.16-derived kernel.

I neglected to mention kernel command-line options earlier:

iommu=on,pt amd_iommu=on

Thanks,
Gregor
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
