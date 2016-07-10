From: sunnydrake <sunnydrake7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Regression] Amd-Vi + ivrs_ioapic cause kernel oops (4.4, 4.7
	fail 3.9 works)
Date: Sun, 10 Jul 2016 11:48:10 +0300
Message-ID: <57820BCA.3070400@gmail.com>
References: <57786362.1010702@gmail.com>
	<790da4e5-985a-a4f5-1ead-b4fa1f37e8a4@iommu.org>
	<57797A37.4030805@gmail.com>
	<6a84fd9d-6897-2b19-de87-be09722593dc@iommu.org>
	<577B13D5.7030200@gmail.com> <577B26C3.6040108@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <577B26C3.6040108-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

after applying patch " [PATCH] iommu/amd: Fix unity mapping 
initialization 
race<https://lists.linuxfoundation.org/pipermail/iommu/2016-July/017781.html>" 
https://lists.linuxfoundation.org/pipermail/iommu/2016-July/017781.html 
kernel boots but then freeze in Login Manager
