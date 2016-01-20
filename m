From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 0/4]IOMMU: avoid lock contention in iova allocation
Date: Wed, 20 Jan 2016 13:21:03 +0100
Message-ID: <20160120122103.GE18805@8bytes.org>
References: <cover.1452297604.git.shli@fb.com>
	<20160110225610.GA16778@cs.technion.ac.il>
	<20160111033749.GA1811285@devbig084.prn1.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160111033749.GA1811285-tb7CFzD8y5b7E6g3fPdp/g2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Jan 10, 2016 at 07:37:59PM -0800, Shaohua Li wrote:
> I don't know you already posted one. Roughly looked at the patches. We
> are using exactly the same idea. I'm happy we pursue your patches. At
> the first look, the per-cpu allocation in your patch doesn't check
> pfn_limit, that could be wrong, but should be easy to fix. I'll take a
> close look tomorrow.

Sounds great. Your approaches with the per-cpu are pretty similar, so I
would appreciate if you two come up with a combined patch-set?


	Joerg
